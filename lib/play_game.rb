class BattleShip
  attr_reader :ship

  def initialize(board)
    @board = board
    @computer_ship_1 = Ship.new("submarine", 2)
    @computer_ship_2 = Ship.new("cruiser", 3)
    @user_ship_1 = Ship.new("cruiser", 3)
    @user_ship_2 = Ship.new("submarine", 2)
  end

  def start_game
    puts "Welcome to Battleship."
    puts  "Enter p to Play or q to Quit"
    input = gets.chomp.downcase
      if input ==  "p"
        setup_game
      else
        puts "Goodbye from Battleship. Play again soon."
      end
  end
  def place_computer_ship(ship)

    coords = @board.cells.keys.sample(ship.length)

    until @board.validate_placement?(ship, coords)
        coords = @board.cells.keys.sample(ship.length)
    end
      @board.place(ship, coords)
  end

  def place_player_ship(ship)

    puts "Enter the squares for the #{ship.name.captialize}(#{ship.length} spaces):"
    user_placement = gets.chomp.to_a
    until @board.validate_placement?(ship, user_placement)
      if @board.validate_placement?(ship, user_placement)
        @board.place(ship, user_placement)
      else
          "Those are invalid coordinates. Please try again."
      end
    end
  end

  def setup_game

    place_computer_ship(@computer_ship_1)
    place_computer_ship(@computer_ship_2)


    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long"

    @board.render

    place_player_ship(@user_ship_1)
    place_player_ship(@user_ship_2)

  end

  def take_turn
    user_placement
  end

  def results
  end

end
