require 'dicechucker'

class Character

  D = Dicechucker # For ease

  attr_accessor :str, :dex, :con, :int, :wis, :cha, :pos
  def inititialize
    [@str, @dex, @con, @int, @wis, @cha].each do |stat|
      stat = D.parse("4d6L").roll
    end
  end
end
