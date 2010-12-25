class Die
  def initialize sides
    @sides = sides
  end

  def sides
    @sides
  end

  def roll
    @face = rand(@sides-1)+1
  end

  def value
    @face
  end
end
