# -*- coding: utf-8 -*-
# Author::  Oddmund Strømme (mailto:oddmund@oddmundo.com)

# An Action object stores an object and a method call for later use in
# e.i. an Action Manager or Timeline.

class Action

  def initialize object, verb
    @object = object
    @verb = verb
  end

  def act
    @object.send(@verb)
  end
end

describe Action do
  it "act" do
    o = Object.new
    a = Action.new(o, :hash)
    o.should_receive(:hash)
    a.act
  end
end

class ActionMapper
  @actions = []

  def add action
    @actions ||= []
    @actions << action
  end

  def action input
    @actions.first
  end
end

describe ActionMapper do
  it "penis" do
    am = ActionMapper.new
    a = Action.new(Object.new, :hash)

    am.add(a) do |input| input == 'i' end
    am.action('i').should == a
  end
end
