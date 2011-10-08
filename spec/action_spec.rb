require 'svirfneblin/actionmapper'
require 'svirfneblin/action'

describe ActionMapper do
  it "penis" do
    am = ActionMapper.new
    a = Action.new(Object.new, :hash)

    am.add(a) do |input| input == 'i' end
    am.action('i').should == a
  end
end
