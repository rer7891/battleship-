class Ship
  attr_reader :name, :length, :health, :sunk_status
  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end
  def hit
   @health -= 1
  end
  def sunk?
    if @health >= 1
      @sunk_status = false
    else
      @sunk_status = true
  end 
end
