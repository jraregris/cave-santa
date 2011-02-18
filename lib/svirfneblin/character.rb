require 'dicechucker'

class Character

  D = Dicechucker # For ease

  attr_accessor :str, :dex, :con, :int, :wis, :cha, :pos
  def initialize type
    @str = D.parse("4d6L").roll
    @dex = D.parse("4d6L").roll
    @con = D.parse("4d6L").roll
    @int = D.parse("4d6L").roll
    @wis = D.parse("4d6L").roll
    @cha = D.parse("4d6L").roll

    if type == :svirfneblin
      @str = @str - 2
      @dex = @dex + 2
      @wis = @wis + 2
      @cha = @cha - 4      
    end
  end
end
