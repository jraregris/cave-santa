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
  end

  context "[]" do
    it "should return cell(x,y) when asked for it" do
      map = Map.new(80,25)
      map[30,30].should == map.cells(30,30)
    end
  end
end
