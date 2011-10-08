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
