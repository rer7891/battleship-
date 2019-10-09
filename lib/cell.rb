class Cell
  attr_reader :coordinate, :ship, :empty, :damaged
  attr_accessor :render, :fire_counter
  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @render = "."
    @fire_counter = 0
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
    @fire_counter += 1
    @ship.health -= 1 if self.ship
  end

  def fired_upon?
    if @fire_counter == 0
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
