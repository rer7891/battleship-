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
    @fires_upon = true
    @ship.health -= 1 if !empty?
  end

  def fired_upon?
     @fires_upon
  end

  def render(ship_view = false)
    if ship_view = true && fired_upon? == false && !empty?
      "S"
    elsif fired_upon? == false && ship_view == false
      "."
    elsif empty? && fired_upon? == false
      "M"
    elsif !empty? && fired_upon? == true
      "H"
    elsif ship.sunk?
      "X"
    end
  end
end
