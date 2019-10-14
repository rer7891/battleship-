class Ship
  attr_reader :name, :length, :sunk_status, :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
    @sunk_status = false
  end

  def hit
   @health -= 1
  end

  def sunk?
    @sunk_status = true if @health < 1
  end
end
