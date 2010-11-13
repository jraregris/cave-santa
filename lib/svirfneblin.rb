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

  def draw
    @display.redraw
    (0..20).each do |y|
      (0..70).each do |x|
        if @map[x][y] != nil
          @display.place x, y, @map[x][y].to_s
        end
      end
    end
    @display.place @hero.x, @hero.y, "@"
  end

  def handle
    c = $<.getc
  end
end
