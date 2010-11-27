require 'svirfneblin/coordinate'

class Map
  attr_reader :width, :height

  def initialize width, height, &blk
    @width, @height = width, height
    @cells = {}
    (0..width-1).each do |x|
      (0..height-1).each do |y|
        @cells[Coordinate.new(x,y)] = '.'
      end
    end
    blk.call self if blk
  end

  def cells x=nil, y=nil
    if not (x or y)
      return @cells
    end
    @cells[Coordinate.new(x,y)]
  end

  def [](x,y)
    @cells[Coordinate.new(x,y)]
  end

  def seed n, c
    n.times do
      @cells[Coordinate.new(rand(@width),rand(@height))] = c
    end
  end

  def make_border c='#'
      n = @cells.select do |k,v|
        k.x == 1 || k.x == @width-1 || k.y == 1 || k.y == @height-1
      end
      n.each do |k,v|
        @cells[k] = c
      end
  end

  def make_exit
    @cells[Coordinate.new(@width/2,@height-1)] = '<'
  end
end
