# -*- coding: utf-8 -*-
require 'luck'

class Svirfneblin
  def initialize
    @display = Luck::Display.new nil
    @pane = Luck::Pane.new @display, 0, 0, @display.width, @display.height, "SVIRFNEBLIN"
    @display.pane :main, @pane
    @pane.control :labia, Luck::Label, 2, 2, @pane.width, @pane.height

    @level = ""
    @level << ".........................................\n"
    @level << "...............╱.........................\n"
    @level << "...............│..........................\n"
    @level << ".......┌───────╯──┐......................\n"
    @level << ".......│          │......................\n"
    @level << ".......│    @     ┊......................\n"
    @level << ".......│          ┊......................\n"
    @level << ".......╘══════════╛......................\n"
    @level << ".........................................\n"
    @level << ".........................................\n"

    @pane.controls[:labia].text = @level
  end

  def run
    begin
      @display.handle
      gets
    rescue => ex
      @display.close
      p ex.class, ex.message, ex.backtrace
    end
  end
end
