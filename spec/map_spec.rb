require 'svirfneblin/map'

describe Map do
  context "new" do
    it "should have w*h cells" do
      map = Map.new(80,25)
      map.cells.size.should be 2000
    end

    it "should have w width and h height" do
      map = Map.new(80,25)
      
      map.width.should be 80
      map.height.should be 25
    end
    it "should have lots of '.'-s" do
      map = Map.new(1,1)
      map.cells(0,0).should == '.'
    end
  end
end
