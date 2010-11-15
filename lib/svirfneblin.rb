require 'bundler'
Bundler.setup
require 'luck'

@@WIDTH = 80
@@HEIGHT = 24

class Coordinate
  def initialize(x,y)
    @x,@y = x,y
  end

  def x
    @x
  end

  def y
    @y
  end
end

class Svirfneblin
  def initialize
    @display = Luck::Display.new nil
    @map = Array.new(@@WIDTH).map! { Array.new(@@HEIGHT) }
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
    puts "Thank you for playing Svirfneblin."
  end

  def draw
    @display.redraw
    (0..20).each do |y|
      (0..70).each do |x|
        if @map[x][y] != nil
          @display.place x, y, @map[x][y].to_s
        end
      end
    end
    @display.place @hero.y, @hero.x, "@"
  end

  def handle
    c = $<.getc
    if(c=='r')
      @hero = Coordinate.new(rand(50),rand(50))
    elsif(c=='j')
      @hero = Coordinate.new(@hero.x,@hero.y+1)
    elsif(c=='k')
      @hero = Coordinate.new(@hero.x,@hero.y-1)
    elsif(c=='h')
      @hero = Coordinate.new(@hero.x-1,@hero.y)
    elsif(c=='l')
      @hero = Coordinate.new(@hero.x+1,@hero.y)
    elsif(c=='q')
      @exit = true
    end
  end
end
