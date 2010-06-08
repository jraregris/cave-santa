# -*- coding: utf-8 -*-
require 'ncurses'

WIDTH = 80
HEIGHT = 13

@x = rand(WIDTH)
@y = rand(HEIGHT)

map = []
map << "................................................................................"
map << "................................................................................"
map << "...SVIRFNEBLIN......###########################.###.#####......................."
map << "........................................................#......................."
map << "....................#...................................#......................."
map << "...####################################################.#......................."
map << "...#....................................................#......................."
map << "...#.############################################.#######......................."
map << "...#............................................................................"
map << "...#................#########################.######.####......................."
map << "...#.............####...#...#...#...#...................#......................."
map << "...#..................#...#...#...#...#.................#......................."
map << "...######################################################......................."
map << "................................................................................"


begin    
  window = Ncurses.initscr
  Ncurses.cbreak
  Ncurses.keypad(window, true)
  Ncurses.curs_set(0)

  title = "SVIRFNEBLIN"
  version = "0.002"
  by = "by"
  author = "oddmunds"


  window.move(HEIGHT/2, (WIDTH/2)-(title.length/2))
  window.attron(Ncurses::A_UNDERLINE)
  window.addstr(title)
  window.attrset(Ncurses::A_NORMAL)
  window.move(HEIGHT/2+1, (WIDTH/2)-(version.length/2))
  window.addstr(version)
  window.move(HEIGHT/2+3, (WIDTH/2)-(by.length/2))
  window.addstr(by)
  window.move(HEIGHT/2+4, (WIDTH/2)-(author.length/2))
  window.addstr(author)

  while((c = window.getch) != 113) #q
    case c
    when Ncurses::KEY_LEFT
      @x = @x - 1 unless map[@y][@x-1] == "#"
    when Ncurses::KEY_RIGHT
      @x = @x + 1 unless map[@y][@x+1] == "#"
    when Ncurses::KEY_UP
      @y = @y - 1 unless map[@y-1][@x] == "#"
    when Ncurses::KEY_DOWN
      @y = @y + 1 unless map[@y+1][@x] == "#"
    end
    
    window.clear
    
    i = 0
    map.each { |l|
      i = i + 1
      window.move(i,0)
      window.addstr(l)
     
    }



    window.move(0,0)
    window.attron(Ncurses::A_REVERSE)
    window.addstr(" X: " + @x.to_s + " Y: " + @y.to_s + " Key: " + c.to_s + " ")
    window.move(0,WIDTH-16)
    window.addstr("Press q to quit ")
window.attrset(Ncurses::A_NORMAL)
    
    
    window.move(@y+1,@x)

    window.addstr("@")
    window.refresh
  end
ensure
  Ncurses.endwin
end
