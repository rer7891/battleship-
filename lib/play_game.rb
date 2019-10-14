class BattleShip
  attr_reader :ship

  def initialize(board)
    @board = board
  end

  def start_game
    puts "Welcome to Battleship.
    puts  Enter p to Play or q to Quit"
    input = gets.chomp.downcase
      if input ==  "p"
        setup_game
      else
        puts "Goodbye from Battleship. Play again soon."
      end
  end
  def place_computer_ship(ship)

    coords = @board.cells.values.sample(ship.length)
      new_coords = coords.map do |coord|
        coord.coordinate
      end

    valid_coordinates = false

    while valid_coordinates == false
      if @board.validate_placement?(ship, new_coords) == true
        @board.place(ship, new_coords)
        valid_coordinates = true
      else
        coords = @board.cells.values.sample(ship.length)
          new_coords = coords.map do |coord|
          coord.coordinate
        end
      end
    end
  end

  def place_player_ship
  end

  def setup_game
    @ship_1 = Ship.new("submarine", 2)
    @ship_2 = Ship.new("cruiser", 3)
    place_computer_ship(@ship_1)
    place_computer_ship(@ship_2)
    @board.render
  end

  def take_turn
  end

  def results
  end

end
