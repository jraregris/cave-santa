class Cell
  attr_accessor :face

  def initialize(face=nil)
    self.face = face
    @neighbors = {}
  end

  def []=(key, cell)
    @neighbors[key] = cell
  end

  def [] key
    @neighbors[key]
  end

  def neighbors &block
    @neighbors
  end
  
  def neighbors_with_face f
    balls = @neighbors.reject do |k,v|
      v.face != f
    end
    balls.size
  end
end
