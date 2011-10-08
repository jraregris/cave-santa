require 'bundler'
Bundler.setup

require 'svirfneblin/map'
require 'svirfneblin/direction'
require 'svirfneblin/display'
require 'svirfneblin/character'

class Svirfneblin
  def initialize
    @hero = Character.new(:svirfneblin)
    make_map
    @exit = false
  end

  def make_map
    @map = Map.new(80,25) do |map|
      map.make_cave
      map.make_border
      map.polarize!
      map.make_exit
    end
    random_hero
 end

  def run
    begin
      @display = Display.new
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

    elsif(c=='h'||c=='4')
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



    if @map[@hero.pos,@hero.pos].face == '<'
      win
    end
  end

  def random_hero
    @hero.pos = @map.random_floor_coord
  end


  def move_hero dir
    @hero.pos = @hero.pos + dir unless @map[@hero.pos + dir].face == '#'
  end

  def win
    @win = true
    @exit = true
  end
end
