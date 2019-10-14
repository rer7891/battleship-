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
  def place_computer_ships(ship)

    coords = @board.cells.values.sample(2)
    new_coords = coords.map do |coord|
     coord.coordinate
    end

    while @board.ship_placed?(new_coords) == false
      if @board.validate_placement?(ship, new_coords) == true
        @board.place(ship, new_coords)
      else
        coords = @board.cells.values.sample(2)
          new_coords = coords.map do |coord|
          coord.coordinate
        end
      end
    end
  end
  def place_player_ships
  end 
  def setup_game
    @ship_1 = Ship.new("submarine", 2)
    @ship_2 = Ship.new("cruiser", 3)
    place_game_ships(@ship_1)
    place_game_ships(@ship_2)
  end

  def take_turn
  end

  def results
  end

end
