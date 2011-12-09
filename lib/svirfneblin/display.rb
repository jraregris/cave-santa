require 'ncursesw'

class Display
  def initialize
    @adapter = NcurseswAdapter.new
  end
  
  def close
    @adapter.close    
  end

  def getc
    @adapter.getc
  end

  def redraw
    @adapter.redraw
  end

  def place x, y, tile
    @adapter.place x, y, tile
  end

  def clear
    @adapter.clear
  end

  def bs
    @adapter.bs
  end
end

class NcurseswAdapter
  def bs
    Ncurses::KEY_BACKSPACE
  end

  def initialize
    @s = Ncurses.initscr
    Ncurses.cbreak
    Ncurses.noecho
    Ncurses.curs_set(0)

    Ncurses.start_color

    Ncurses.init_pair(1, 2, 0)
    Ncurses.init_pair(2, 3, 0)
    Ncurses.init_pair(3, 4, 0)
    Ncurses.init_pair(4, 5, 0)
    Ncurses.init_pair(5, 6, 0)
    Ncurses.init_pair(6, 7, 0)

    @colormap = Hash.new(Ncurses.COLOR_PAIR(3))

    @colormap['#'] = Ncurses.COLOR_PAIR(1)
    @colormap['&'] = Ncurses.COLOR_PAIR(2)
    @colormap['o'] = Ncurses.COLOR_PAIR(4)
    @colormap['C'] = Ncurses.COLOR_PAIR(5)
    @colormap['*'] = Ncurses.COLOR_PAIR(6)
  end

  def clear
    Ncurses.clear
  end

  def close
    Ncurses.endwin
  end

  def redraw
    Ncurses.refresh
    
  end

  def place x, y, tile
    @s.attrset(@colormap[tile])
    @s.mvaddstr y, x, tile.to_s
  end

  def getc
    c = Ncurses.stdscr.getch.chr
  end
end
