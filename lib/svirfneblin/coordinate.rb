class Coordinate
  attr_reader :x, :y
  def initialize x,y
    @x,@y = x,y
  end

  def ==(other)
    if(@x == other.x && @y == other.y)
      return true
    end
    false
  end

  def eql?(other)
    self == other
  end

  def hash
    @x.hash + @y.hash
  end

  def to_s
    @x.to_s + "," + @y.to_s
  end

  def + other
    Coordinate.new(@x+other.x,@y+other.y)
  end
end
