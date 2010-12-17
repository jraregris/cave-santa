require 'svirfneblin/direction'

describe Direction do
  it "should have x and y value" do
    d = Direction.new 3,4

    d.x.should be 3
    d.x.should_not be 4
    d.y.should be 4
    d.y.should_not be 3
  end

  it "should equal other directions with the same x,y" do
    d1 = Direction.new 3,4
    d2 = Direction.new 3,4

    d1.should equal d2
  end

  it "should have cardinal constants" do
    N.should equal Direction.new 0,-1
    NE.should equal Direction.new 1,-1
    E.should equal Direction.new 1,0
    SE.should equal Direction.new 1,1
    S.should equal Direction.new 0,1
    SW.should equal Direction.new -1,1
    W.should equal Direction.new -1,0
    NW.should equal Direction.new -1,-1
  end

  it "should me multiplicaple" do
    d = N*2
    d.should equal Direction.new 0,-2
    d = d*100
    d.should equal Direction.new 0,-200
  end

end
