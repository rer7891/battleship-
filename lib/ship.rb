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
    if @health >= 1
      @sunk_status = false
    else
      @sunk_status = true
    end
  end
end
