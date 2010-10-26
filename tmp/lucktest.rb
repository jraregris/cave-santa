#!/usr/bin/env ruby
require 'luck'

begin
  i = 0;
  d = Luck::Display.new nil

  p = Luck::Pane.new d, 0, 0, d.width, d.height, "SVIRFNEBLIN"
  d.pane :main, p

  p.control :labia, Luck::Label, 2, 2, p.width, p.height do
    @map = text
    @map << "................................................................................\n"
    @map << "................................................................................\n"
    @map << "...SVIRFNEBLIN......###########################.###.#####.......................\n"
    @map << "........................................................#.......................\n"
    @map << "....................#...................................#.......................\n"
    @map << "...####################################################.#.......................\n"
    @map << "...#....................................................#.......................\n"
    @map << "...#.############################################.#######.......................\n"
    @map << "...#............................................................................\n"
    @map << "...#................#########################.######.####.......................\n"
    @map << "...#.............####...#...#...#...#...................#.......................\n"
    @map << "...#..................#...#...#...#...#.................#.......................\n"
    @map << "...######################################################......................"
    @map <<
    "................................................................................"
    text = @map
  end
  
  while sleep 0.01
    d.handle
    i = i + 0.01
  end
rescue => ex
  d.close
  p ex.class, ex.message, ex.backtrace
end
