class Ship
  attr_reader :name, :length, :sunk_status
  attr_accessor :health
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
    @sunk_status == true if @health == 0 
  end
end
