class Cell
  attr_reader :coordinate, :ship, :empty
  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @fires_upon = false
  end

  def empty?
   if @ship == nil
    @empty
   else
    @empty = false
   end
  end

  def place_ship(ship)
    @ship = ship
    empty?
  end

  def fire_upon
    @ship.hit if !empty?
      @fires_upon = true
  end

  def fired_upon?
     @fires_upon
  end

  def render(ship_view = false)
    if !fired_upon? && !ship_view || !fired_upon? && empty? && ship_view
      "."
    elsif !fired_upon? && !empty? && ship_view
       "S"
    elsif empty? && fired_upon?
      "M"
    elsif !empty? && fired_upon? && !ship.sunk?
      "H"
    elsif fired_upon? && !empty? && ship.sunk?
      "X"
    end
  end
end
