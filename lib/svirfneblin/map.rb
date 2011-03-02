require 'svirfneblin/cell'
require 'svirfneblin/coordinate'
require 'svirfneblin/direction'

class Map
  attr_reader :width, :height

  def initialize width, height, &blk
    @width, @height = width, height
    @cells = {}
    (0..width-1).each do |x|
      (0..height-1).each do |y|
        @cells[Coordinate.new(x,y)] = Cell.new '#'
      end
    end

    (0..width-1).each do |x|
      (0..height-1).each do |y|
        @cells[Coordinate.new(x,y)][N]  = @cells[Coordinate.new(x,y-1)]   if @cells[Coordinate.new(x,y-1)]
        @cells[Coordinate.new(x,y)][NE] = @cells[Coordinate.new(x+1,y-1)] if @cells[Coordinate.new(x+1,y-1)]
        @cells[Coordinate.new(x,y)][E]  = @cells[Coordinate.new(x+1,y)]   if @cells[Coordinate.new(x+1,y)]
        @cells[Coordinate.new(x,y)][SE] = @cells[Coordinate.new(x+1,y+1)] if @cells[Coordinate.new(x+1,y+1)]
        @cells[Coordinate.new(x,y)][S]  = @cells[Coordinate.new(x,y+1)]   if @cells[Coordinate.new(x,y+1)]
        @cells[Coordinate.new(x,y)][SW] = @cells[Coordinate.new(x-1,y+1)] if @cells[Coordinate.new(x-1,y+1)]
        @cells[Coordinate.new(x,y)][W]  = @cells[Coordinate.new(x-1,y)]   if @cells[Coordinate.new(x-1,y)]
        @cells[Coordinate.new(x,y)][NW] = @cells[Coordinate.new(x-1,y-1)] if @cells[Coordinate.new(x-1,y-1)]
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

  def make_cave n, c = '.'
    n.times do
      coord = Coordinate.new(rand(@width/2)+rand(@width/2), rand(@height/2)+rand(@height/2))
      @cells[coord].face = '.' if @cells[coord].face == '#'
    end
  end

  def seed n, c
    n.times do
      @cells[Coordinate.new(rand(@width),rand(@height))].face = c
    end
  end

  def make_border c='#'
      n = @cells.select do |k,v|
        k.x == 0 || k.x == @width-1 || k.y == 0 || k.y == @height-1
      end
      n.each do |k,v|
        @cells[k].face =  c
      end
  end

  def polarize!
    @cells.each_pair do |co, ce|
      @cells[co].face = '#' if ce.neighbors_with_face('#') > 4
      @cells[co].face = '.' if ce.neighbors_with_face('#') < 2
    end
  end

  def make_exit
    nooks = []
    
    @cells.each_value do |c|
      nooks << c if (c.neighbors_with_face('#') > 4 && c.neighbors_with_face('.') > 0)
    end
    nooks.shuffle.first.face = '<'
  end

  def random_floor_coord
    floors = []
    @cells.each_pair do |co,ce|
      floors << co if ce.face == '.'
    end
    floors.shuffle.first
  end
end
