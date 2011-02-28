# -*- coding: utf-8 -*-
class Cell
  attr_accessor :face

  def initialize(face=nil)
    self.face = face
  end

  def []=(key, cell)
    @neighbors ||= {}
    @neighbors[key] = cell
  end

  def [] key
    @neighbors[key]
  end

  def neighbors &block
    @neighbors
  end
  
  def neighbors_with_face f
    @neighbors.keep_if do |k,v|
      v.face == f
    end
  end
end

describe Cell do
  it "should hold a char" do
    c = Cell.new
    c.face = '&'
    c.face.should == '&'
  end

  it "shouls accept face in the init" do
    c = Cell.new 'ł'
    c.face.should == 'ł'
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

    it 'neighbors should take a block with limits' do
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
      
      c.neighbors_with_face('y').should == {:north => d, :east => e}
    end
  end
end
