require 'luck'

class Display
  def initialize adapter=:ncurses
    @adapter = LuckAdapter.new if adapter==:luck
  end
  
  def close
    @adapter.close    
  end

  def redraw
    @adapter.redraw
  end

  def place x, y, tile
    @adapter.place x, y, tile
  end
end

class LuckAdapter
  def initialize
    @d = Luck::Display.new nil
  end

  def close
    @d.close
  end

  def redraw
    @d.redraw
  end

  def place x, y, tile
    @d.place x, y, tile
  end

end
