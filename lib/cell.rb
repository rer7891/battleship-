class Cell
  attr_reader :coordinate, :ship, :empty, :damaged
  attr_accessor :render
  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @render = "."
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
  end

  def fire_upon
    @ship.health -= 1
  end
  def fired_upon?
    if @ship.health == @ship.length
      @damaged = false
    else
      @damaged = true
    end
  end
  def render_cell
    if @damaged == true
      @render = "M"
    else
      @render = "H"
    end
  end

end
