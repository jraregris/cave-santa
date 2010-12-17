class Direction
  attr_reader :x, :y

  def initialize x, y
    @x, @y = x, y
  end

  def equal? other
    @x == other.x && @y == other.y
  end
end

N = Direction.new 0,-1
NE = Direction.new 1,-1
E = Direction.new 1,0
SE = Direction.new 1,1
S = Direction.new 0,1
SW = Direction.new -1,1
W = Direction.new -1,0
NW = Direction.new -1,-1
