require 'bundler'
Bundler.setup

require 'svirfneblin/map'
require 'svirfneblin/direction'
require 'svirfneblin/display'
require 'svirfneblin/character'

class Svirfneblin
  def initialize
    @hero = Character.new(:svirfneblin)
    @level = 1
    make_map

    @presents, @giftings, @turns = 0,0,0
    @messages = ["Spread the joy of Cave Christmas!"]
    @exit = false
  end

  def make_map
    @map = Map.new(80,23) do |map|
    
      map.make_cave
      map.make_border
      map.polarize!
      map.make_exit
      map.make_orphans @level*2
      map.make_presents @level==1?2:(@level*2)-1
      map.make_cannibals @level*10
    end
    random_hero
  end

  def run
    begin
      @display = Display.new
      @display.place 1,1,"Welcome to Cave Santa!"

      @display.place 1,3,"It's Cave Christmas and you are"
      @display.place 1,4,"Cave Santa. You must deliver as many"
      @display.place 1,5,"Cave Presents to the Cave Orphans as"
      @display.place 1,6,"you can before you get eaten by"
      @display.place 1,7,"the Cave Cannibals!"
       
      @display.place 1,9,"Navigate the Caves by pressing"
      @display.place 1,10,"the vikeys or numpad. Interact with"
      @display.place 1,11,"things by walking on them."
       
      @display.place 1,13,"Be the Best Cave Santa and get on"
      @display.place 1,14,"the High Score table!"
     
      @display.place 1,17,"                           ^"
      @display.place 1,18,"                         \\ | /      y k u     7 8 9"
      @display.place 1,19,"                        <- * ->     h . l     4 5 6"
      @display.place 1,20,"                         / | \\      b j n     1 2 3"
      @display.place 1,21,"                           v"

      @display.place 1,23,"-- press whatever to continue --"

      @display.place 50,3,'&'
      @display.place 50,5,'o'
      @display.place 50,7,'*'
      @display.place 50,9,'C'
      @display.place 50,11,'<'
      @display.place 50,13,'#'

      @display.place 55,3,'<--  Santa'
      @display.place 55,5,'<--  Orphan'
      @display.place 55,7,'<--  Present'
      @display.place 55,9,'<--  Cannibal'
      @display.place 55,11,'<--  Exit'
      @display.place 55,13,'<--  Wall'

      @display.getc

      until @exit == true do
        draw
        handle
      end
      highscore
      quit
    rescue => ex
      @display.close
      p ex.class, ex.message, ex.backtrace
    end
  end

  def highscore

    
    (0...80).each {|x| (0...25).each { |y| @display.place x,y, " " } }

    @display.place 1,1,"Ho ho ho!"
    @display.place 1,3,"You warmed #{@giftings} little hearts"
    @display.place 1,4,"before you got eaten."
    @display.place 1,5,"Please enter you name:"

    @display.place 1,7,"_"
    
    @display.redraw
    @name = ""
    while((c = @display.getc) != "\n")
      if(c == @display.bs)
        @name.chop!
      else
        @name << c
      end

      break if @name.length>20
      @display.place 1,7,"#{@name}_"
      @display.redraw
    end

    (0...80).each {|x| (0...25).each { |y| @display.place x,y, " " } }

    require 'mongo'

    high = Mongo::Connection.new.db("santa")["highscores"]

    score = {
      "name"=>@name, 
      "giftings"=>@giftings, 
      "turns"=>@turns, 
      "presents"=>@presents, 
      "level"=>@level, 
      "time"=> Time.now}

    high.insert score
    hs = high.find({}).sort(["giftings",:desc]).limit(10)

    i = 1
    @display.place 1,2,"    Name              Giftings"
    hs.each do |h|
      @display.place 1,3+i," #{i.to_s}  #{h["name"]}"
      @display.place 30,3+i,"#{h["giftings"]}"
#      @display.place 40,3+i,"#{h["turns"]}"
      i += 1
    end
    @display.redraw
    @display.getc
  end

  def quit
    @display.close
    puts "Thank you for playing Svirfneblin."
  end

  def draw
    @map.cells.each { |coord, char|
      @display.place coord.x, coord.y, char.face
    }
    @map.orphans.each { |o| @display.place o.pos.x, o.pos.y, "o"}
    @map.presents.each { |p| @display.place p.pos.x, p.pos.y, "*"}
    @map.cannibals.each { |c| @display.place c.pos.x, c.pos.y, "C"}
    @display.place @hero.pos.x, @hero.pos.y, "&"

    if @messages.empty?
      @display.place 0,23, "                                                                                "
    else
      @display.place 0,23, @messages.join(" ")
      @messages = []
    end

    @display.place 0,24, "Presents: #{@presents}  Giftings: #{@giftings}  Level: #{@level}  Turns: #{@turns}"
    @display.redraw
  end

  def handle
    c = @display.getc

    @turns += 1

    x,y = @hero.pos.x, @hero.pos.y

    dir = Direction.new(0,0)

#    if(c=='r')
#      random_hero
#    elsif(c=='R')
#      make_map
#    elsif(c=='P')
#      @map.polarize!
#      @map.make_border '#'

    if(c=='h'||c=='4')
      move_hero W
    elsif(c=='j'||c=='2')
      move_hero S
    elsif(c=='k'||c=='8')
      move_hero N
    elsif(c=='l'||c=='6')
      move_hero E
    elsif(c=='y'||c=='7')
      move_hero NW
    elsif(c=='u'||c=='9')
      move_hero NE
    elsif(c=='b'||c=='1')
      move_hero SW
    elsif(c=='n'||c=='3')
      move_hero SE

    elsif(c=='q')
      @exit = true
    end

    @map.move_cannibals
    @map.cannibals_eat_orphans

    @presents += 1 if @map.take_present(@hero.pos)
    
    if @presents > 0
      boob = @map.give_present @hero.pos
      if boob == :gifted
        @messages << "You give the orphan a gift!"
        @presents -= 1
        @giftings += 1
      end
      if boob == :already_gifted
        @messages << "You spoil the orphan. Boo!"
        @giftings -= 1
        @presents -= 1
      end
      if boob == :already_spoiled
        @messages << "You waste the gift on a spoiled shit kid."
        @presents -= 1
      end        
    end

    if @map.cannibals_eat_hero?(@hero.pos)
      lose
    end

    if @map[@hero.pos,@hero.pos].face == '<'
     next_level 
    end
  end

  def next_level
    @level += 1
    @messages << "You descend to the next level."
    make_map
  end

  def random_hero
    @hero.pos = @map.random_floor_coord
  end


  def move_hero dir
    @hero.pos = @hero.pos + dir unless @map[@hero.pos + dir].face == '#'
  end

  def lose
    @exit = true
  end
end


