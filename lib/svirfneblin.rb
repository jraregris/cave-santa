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

    @hero.pos = @hero.pos + dir unless @map[@hero.pos + dir].face == '#'

    if @map[@hero.pos,@hero.pos].face == '<'
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
