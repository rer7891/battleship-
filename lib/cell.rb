class Cell
  attr_reader :coordinate, :ship, :empty, :damaged
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
    if @fire_counter == 0
        @damaged = false
    else
        @damaged = true
    end
  end

  def render
    if fired_upon? == false
      @render_cell = "."
    elsif empty? && fired_upon? == true
      @render_cell = "M"
    elsif !empty? && fired_upon? == true
      @render_cell  = "H"
    end
  end

end
