require 'svirfneblin/coordinate'

describe Coordinate do
  context "equals" do
    it "should equal with the same x and y" do
      one = Coordinate.new(0,0)
      two = Coordinate.new(0,0)
      one.should == two
    end
  end

  context "hash" do
    it "should hash to the same as long as x and y are the same" do
      one = Coordinate.new(0,0)
      two = Coordinate.new(0,0)
      one.hash.should == two.hash
    end
  end
end
