require 'svirfneblin/coordinate'

class Map
  attr_reader :width, :height

  def initialize width, height
    @width, @height = width, height
    @cells = {}
    (0..width-1).each do |x|
      (0..height-1).each do |y|
        @cells[Coordinate.new(x,y).to_s] = '.'
      end
    end
  end

  def cells x=nil, y=nil
    if not (x or y)
      return @cells
    end
    @cells[Coordinate.new(x,y).to_s]
  end
end
