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
