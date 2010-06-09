require 'ncurses'

@x = rand(80)
@y = rand(25)

begin    
  window = Ncurses.initscr
  Ncurses.cbreak
  Ncurses.keypad(window, true)
  Ncurses.curs_set(0)

  while((c = window.getch) != 113) #q
    case c
    when Ncurses::KEY_LEFT
      @x = @x - 1
    when Ncurses::KEY_RIGHT
      @x = @x + 1
    when Ncurses::KEY_UP
      @y = @y - 1
    when Ncurses::KEY_DOWN
      @y = @y + 1
    end
    
    window.clear
    window.move(0,0)
    window.attron(Ncurses::A_REVERSE)
    window.addstr(" X: " + @x.to_s + " Y: " + @y.to_s + " Key: " + c.to_s + " ")
    window.attrset(Ncurses::A_NORMAL)
    window.addstr(" Press q to quit")
    window.move(@y,@x)

    window.addstr("@")
    window.refresh
    
  end
ensure
  Ncurses.endwin
end
