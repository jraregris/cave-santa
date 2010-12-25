require 'svirfneblin/die'

describe Die do
  it "should have variable sides" do
    Die.new(4).sides.should be 4
    Die.new(6).sides.should be 6
  end

  it "roll should give it a random value between 1 and sides" do
    d = Die.new 6
    n = d.roll

    n.should be > 0 
    n.should be < 7
  end

  it "value should return the rolled value" do
    d = Die.new 6
    n = d.roll
    d.value.should be n
  end
 end
