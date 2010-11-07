# -*- coding: utf-8 -*-
require 'luck'
require 'luck/canvas'

class Svirfneblin
  def run
    begin
      d = Luck::Display.new nil
      p = Luck::Pane.new d, 0,0, d.width, d.height, "SVIRFNEBLIN"
      d.pane :main, p

      p.control :labia, Luck::Label, 2, 2, p.width, p.height do
        @text = ""
        @text << ".........................................\n"
        @text << "...............╱.........................\n"
        @text << "...............│..........................\n"
        @text << ".......┌───────╯──┐......................\n"
        @text << ".......│          │......................\n"
        @text << ".......│    @     ┊......................\n"
        @text << ".......│          ┊......................\n"
        @text << ".......╘══════════╛......................\n"
        @text << ".........................................\n"
        @text << ".........................................\n"
      end

      d.handle
      gets
    rescue => ex
      d.close
      p ex.class, ex.message, ex.backtrace
    end
  end
end
