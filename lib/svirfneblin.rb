require 'bundler'
Bundler.setup

require 'svirfneblin/map'
require 'svirfneblin/display'

class Svirfneblin
  def initialize
    @display = Display.new :luck
    @map = Map.new(80,24) do |m|
      m.seed 50, '#'
      m.make_border '#'
      m.make_exit
    end
    @hero = Coordinate.new(5,5)
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
    @display.redraw

    @map.cells.each { |coord, char|
      @display.place coord.y, coord.x, char
    }

    @display.place @hero.y, @hero.x, "@"
  end

  def handle
    c = $<.getc
    if(c=='r')
      @hero = Coordinate.new(rand(50),rand(50))
    elsif(c=='j')
      @hero = Coordinate.new(@hero.x,@hero.y+1) unless @map[@hero.x,@hero.y+1] == '#' 
    elsif(c=='k')
      @hero = Coordinate.new(@hero.x,@hero.y-1) unless @map[@hero.x,@hero.y-1] == '#' 
    elsif(c=='h')
      @hero = Coordinate.new(@hero.x-1,@hero.y) unless @map[@hero.x-1,@hero.y] == '#' 
    elsif(c=='l')
      @hero = Coordinate.new(@hero.x+1,@hero.y) unless @map[@hero.x+1,@hero.y] == '#' 
    elsif(c=='q')
      @exit = true
    end

    if @map[@hero.x,@hero.y] == '<'
      win
    end
  end

  def win
    @win = true
    @exit = true
  end
end
