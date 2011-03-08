require 'bundler'
Bundler.setup

require 'svirfneblin/map'
require 'svirfneblin/direction'
require 'svirfneblin/display'
require 'svirfneblin/character'

class Svirfneblin
  def initialize
 
    @hero = Character.new(:svirfneblin)


#    @display.place 0,0,"Welcome, brave Svirfneblin!"
#    @display.place 0,1,"STR: #{@hero.str}"
#    @display.place 0,2,"DEX: #{@hero.dex}"
#    @display.place 0,3,"CON: #{@hero.con}"
#    @display.place 0,4,"INT: #{@hero.int}"
#    @display.place 0,5,"WIS: #{@hero.wis}"
#    @display.place 0,6,"CHA: #{@hero.cha}"
    
#    @display.getc
    make_map
    @exit = false
  end

  def make_map
    @map = Map.new(80,25) do |map|
      map.make_cave 2000, '.'
      map.make_border
      map.polarize!
      map.make_exit
    end
 
    random_hero
 end

  def run
    begin
      @display = Display.new :ncursesw
      until @exit == true do
        draw
        handle
      end
      quit
    rescue => ex
      @display.close
      p ex.class, ex.message, ex.backtrace
    end
  end

  def quit
    @display.close
    puts "Congratulations, you win!" if @win
    puts "Thank you for playing Svirfneblin."
  end

  def draw
    @map.cells.each { |coord, char|
      @display.place coord.x, coord.y, char.face
    }

    @display.place @hero.pos.x, @hero.pos.y, "@"

    @display.place 2, 26, "Stone: " + @map.cells.reject {|k,v| v.face != '#'}.size.to_s
    @display.place 2, 27, "Floor: " + @map.cells.reject {|k,v| v.face != '.'}.size.to_s
    @display.place 2, 28, "Cell : " + @map[@hero.pos.x,@hero.pos.y][N].to_s
    @display.redraw
  end

  def handle
    c = @display.getc
 
    x,y = @hero.pos.x, @hero.pos.y

    dir = Direction.new(0,0)

    if(c=='r')
      random_hero
    elsif(c=='R')
      make_map
    elsif(c=='P')
      @map.polarize!
      @map.make_border '#'


    elsif(c=='h')
      dir = W
    elsif(c=='j')
      dir = S
    elsif(c=='k')
      dir = N
    elsif(c=='l')
      dir = E
    elsif(c=='y')
      dir = NW
    elsif(c=='u')
      dir = NE
    elsif(c=='b')
      dir = SW
    elsif(c=='n')
      dir = SE

    elsif(c=='q')
      @exit = true
    end

    target_cell = Coordinate.new(@hero.pos.x, @hero.pos.y)+dir
    @hero.pos = target_cell unless @map[target_cell.x, target_cell.y].face == '#'

    if @map[@hero.pos.x,@hero.pos.y].face == '<'
      win
    end
  end

  def random_hero
    @hero.pos = @map.random_floor_coord
  end

  def win
    @win = true
    @exit = true
  end
end
