require 'bundler'
Bundler.setup

require 'svirfneblin/map'
require 'svirfneblin/direction'
require 'svirfneblin/display'

class Svirfneblin
  def initialize
 
    @display = Display.new :ncursesw
    @display.place 0,0,"Welcome, brave Svirfneblin! Find your way home! --space--"
    @display.getc

    @map = Map.new(80,24) do |map|
      map.seed 500, '#'
      map.make_border '#'
      map.make_exit
    end
    @hero = Coordinate.new(rand(80), rand(24))
      @exit = false
  end

  def run
    begin
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
    @display.clear

    @map.cells.each { |coord, char|
      @display.place coord.x, coord.y, char
    }

    @display.place @hero.x, @hero.y, "@"

    @display.redraw
  end

  def handle
    c = @display.getc
 
    x,y = @hero.x, @hero.y

    dir = Direction.new(0,0)

    if(c=='r')
      @hero = Coordinate.new(rand(80),rand(24))
    elsif(c=='j')
      dir = S
    elsif(c=='k')
      dir = N
    elsif(c=='h')
      dir = W
    elsif(c=='l')
      dir = E
    elsif(c=='q')
      @exit = true
    end

    target_cell = Coordinate.new(@hero.x, @hero.y)+dir
    @hero = target_cell unless @map[target_cell.x, target_cell.y] == '#'

    if @map[@hero.x,@hero.y] == '<'
      win
    end
  end

  def win
    @win = true
    @exit = true
  end
end
