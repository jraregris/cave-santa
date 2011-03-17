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
end

class NcurseswAdapter

  def initialize
    @s = Ncurses.initscr
    Ncurses.cbreak
    Ncurses.noecho
    Ncurses.curs_set(0)

    Ncurses.start_color

    Ncurses.init_pair(1, 243, 0)
    Ncurses.init_pair(2, 102, 0)
    Ncurses.init_pair(3, 238, 0)
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
    if tile == '#'
      @s.attrset(Ncurses.COLOR_PAIR(1))
    elsif tile == '@'
      @s.attrset(Ncurses.COLOR_PAIR(2))
    else
      @s.attrset(Ncurses.COLOR_PAIR(3))
    end
    @s.mvaddstr y, x, tile.to_s

  end

  def getc
    c = Ncurses.stdscr.getch.chr
  end
end
