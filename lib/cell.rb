class Cell
  attr_reader :coordinate, :ship, :empty
  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @fires_upon = false
  end

  def empty?
   if @ship == nil #could refactor down to @empty if @ship == nil
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
    @ship.hit if !empty?
  end

  def fired_upon?
     @fires_upon
  end

  def render(ship_view = false)
    if !fired_upon? && !ship_view
      "."
    elsif ship_view && !fired_upon?
      "S"
    elsif empty? && fired_upon?
      "M"
    elsif @ship.sunk?
      "X"
    elsif !empty? && fired_upon?
      "H"
    end
  end
end
