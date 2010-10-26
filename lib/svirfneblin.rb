require 'luck'

class Svirfneblin
  
  @@VERSION = "0.002-5"

  @@WIDTH = 80
  @@HEIGHT = 13

  def initialize

    @t = 0

    @x = rand(@@WIDTH)
    @y = rand(@@HEIGHT)

    @map = []
    @map << "................................................................................"
    @map << "................................................................................"
    @map << "...SVIRFNEBLIN......###########################.###.#####......................."
    @map << "........................................................#......................."
    @map << "....................#...................................#......................."
    @map << "...####################################################.#......................."
    @map << "...#....................................................#......................."
    @map << "...#.############################################.#######......................."
    @map << "...#............................................................................"
    @map << "...#................#########################.######.####......................."
    @map << "...#.............####...#...#...#...#...................#......................."
    @map << "...#..................#...#...#...#...#.................#......................."
    @map << "...######################################################......................."
    @map << "................................................................................"
  end

  def run
    begin    
      @window = Ncurses.initscr
      Ncurses.cbreak
      Ncurses.keypad(@window, true)
      Ncurses.curs_set(0)

      display_title

      while((c = @window.getch) != 113) #q
        case c
        when Ncurses::KEY_LEFT
          @x = @x - 1 unless @map[@y][@x-1] == "#"
        when Ncurses::KEY_RIGHT
          @x = @x + 1 unless @map[@y][@x+1] == "#"
        when Ncurses::KEY_UP
          @y = @y - 1 unless @map[@y-1][@x] == "#"
        when Ncurses::KEY_DOWN
          @y = @y + 1 unless @map[@y+1][@x] == "#"
        end
    
        @window.clear
    
        i = 0
        @map.each { |l|
          i = i + 1
          @window.move(i,0)
          @window.addstr(l)
        }

        @window.move(0,0)
        @window.attron(Ncurses::A_REVERSE)
        @window.addstr(" X: " + @x.to_s + " Y: " + @y.to_s + " Key: " + c.to_s + " Turn: " + @t.to_s)
        @window.move(0,@@WIDTH-16)
        @window.addstr("Press q to quit ")
        @window.attrset(Ncurses::A_NORMAL)

        @window.move(@y+1,@x)
        @window.addstr("@")

        @window.refresh
        @t = @t + 1
      end
    ensure
      Ncurses.endwin
    end
  end

  def display_title
    title = "SVIRFNEBLIN"
    by = "by"
    author = "oddmunds"
    
    cx = @@WIDTH/2
    cy = @@HEIGHT/2

    write(cx-(title.length/2), @@HEIGHT/2, title, :underline)
    write((@@WIDTH/2)-(@@VERSION.length/2),@@HEIGHT/2+1,@@VERSION)
    write((@@WIDTH/2)-(by.length/2),(@@HEIGHT/2+3),by)
    write((@@WIDTH/2)-(author.length/2),(@@HEIGHT/2+4), author)        
  end

  def write(x,y,text, *attributes)
    if attributes.include?(:underline)
      @window.attron(Ncurses::A_UNDERLINE)
    end

    @window.move(y,x)
    @window.addstr(text)

    @window.attrset(Ncurses::A_NORMAL)
  end
end
