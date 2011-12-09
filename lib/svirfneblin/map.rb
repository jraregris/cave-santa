require 'svirfneblin/cell'
require 'svirfneblin/coordinate'
require 'svirfneblin/direction'
require 'svirfneblin/actor'

class Map
  attr_reader :width, :height, :presents, :cannibals, :orphans

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

    @orphans = []
    @cannibals = []
    @presents = []

    blk.call self if blk
  end

  def cells x=nil, y=nil
    if not (x or y)
      return @cells
    end
    @cells[Coordinate.new(x,y)]
  end

  def [](x=nil,y=nil)
    if x.respond_to?(:x) and x.respond_to?(:y)
      return @cells[x]
    end
    @cells[Coordinate.new(x,y)]
  end

  def make_cave
    2000.times do
      coord = Coordinate.new(rand(@width/2)+rand(@width/2), rand(@height/2)+rand(@height/2))
      @cells[coord].face = '.' if @cells[coord].face == '#'
    end
  end

  def make_orphans n
    n.times { @orphans << Actor.new(random_floor_coord) }
  end

  def make_presents n
    n.times { @presents << Actor.new(random_floor_coord) }
  end

  def take_present hpos
    @presents.each do |p|
      if p.pos == hpos
        @presents.delete(p)
        return true
      end
    end
    false
  end

  def give_present hpos
     @orphans.each do |o|
       if o.pos == hpos
         if o.gifted
           if o.spoiled
             return :already_spoiled
           else
             o.spoiled = true
             return :already_gifted
           end
         else
           o.gifted = true
           return :gifted
         end
       end
     end
     nil
  end


  def make_cannibals n
    n.times { @cannibals << Actor.new(random_floor_coord)}
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

  def move_cannibals
    @cannibals.each do |c|
      n = @cells[c.pos].neighbors.reject {|k,v| v.face != '.'}
      c.pos = (c.pos + n.keys.sample) unless n.empty?
      
    end
  end

  def cannibals_eat_orphans
    @orphans.each do |o|
      @cannibals.each do |c|
        if o.pos == c.pos
          @orphans.delete(o)
        end
      end
    end
  end
  
  def cannibals_eat_hero? hpos
    not @cannibals.select{|c| c.pos == hpos}.empty?
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
