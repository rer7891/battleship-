class Cell
  attr_reader :coordinate, :ship, :empty
  attr_accessor :render_cell, :fire_counter
  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
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
    @ship.health -= 1 if !empty?
  end

  def fired_upon?
     @fire_counter != 0
  end

  def render(ship_view = false)
    if fired_upon? == false && ship_view == false
      @render_cell = "."
    elsif ship_view = true && fired_upon? == false
        @render_cell = "S"
    elsif empty? && fired_upon? == true
      @render_cell = "M"
    elsif sunk?
      @render_cell = "X"
    elsif !empty? && fired_upon? == true
      @render_cell  = "H"
    end
  end

    def sunk?
      @ship.health == 0
    end
end
