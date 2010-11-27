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
    blk.call self unless not blk
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
end
