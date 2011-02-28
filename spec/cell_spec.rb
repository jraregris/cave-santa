# -*- coding: utf-8 -*-
require 'svirfneblin/cell'

describe Cell do
  it "should hold a char" do
    c = Cell.new
    c.face = '&'
    c.face.should == '&'
  end

  it "should accept face in the init" do
    c = Cell.new '¤'
    c.face.should == '¤'
  end

  context 'neighbors' do
    it 'should be accessed by hash' do
      c = Cell.new
      d = Cell.new
      c[:north] = d
      c[:north].should == d
    end
    
    it 'neighbors should return all neighbors' do
      c = Cell.new
      d,e,f,g = Cell.new, Cell.new, Cell.new, Cell.new
      
      c[:north] = d
      c[:east] = e
      c[:south] = f
      c[:west] = g
      
      c.neighbors.should == {:north => d, :east => e, :south => f, :west => g}
    end

    it 'neighbors_with_face should give n of neighbors with that face' do
            c = Cell.new
      d,e,f,g = Cell.new, Cell.new, Cell.new, Cell.new
      
      d.face = 'y'
      e.face = 'y'
      f.face = 'n'
      g.face = 'n'

      c[:north] = d
      c[:east] = e
      c[:south] = f
      c[:west] = g
      
      c.neighbors_with_face('y').should == 2
    end
  end
end
