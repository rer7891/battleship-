class BattleShip
  attr_reader :ship

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @computer_ship_1 = Ship.new("submarine", 2)
    @computer_ship_2 = Ship.new("cruiser", 3)
    @user_ship_1 = Ship.new("cruiser", 3)
    @user_ship_2 = Ship.new("submarine", 2)
  end

  def place_computer_ship(ship)

    coords = @computer_board.cells.keys.sample(ship.length)

    until @computer_board.validate_placement?(ship, coords)
        coords = @computer_board.cells.keys.sample(ship.length)
    end
      @computer_board.place(ship, coords)
  end

  def place_player_ship(ship)
    loop do
      puts "Enter the squares for the #{ship.name.capitalize}(#{ship.length} spaces):"
      user_placement = gets.chomp.split(" ")
        if @player_board.validate_placement?(ship, user_placement)
           @player_board.place(ship, user_placement)
           break
        else
          puts "Those are invalid coordinates. Please try again."
        end
    end
  end
  def start_game
    puts "Welcome to Battleship."
    puts  "Enter p to Play or q to Quit"
    input = gets.chomp.downcase
      if input ==  "p"
        computer_setup_game
      else
        puts "Goodbye from Battleship. Play again soon."
      end
  end

  def computer_setup_game
    place_computer_ship(@computer_ship_1)
    place_computer_ship(@computer_ship_2)

    player_set_up
  end

  def player_set_up
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long"

    @player_board.render

    place_player_ship(@user_ship_1)
    place_player_ship(@user_ship_2)

    take_turn
  end
  def player_fires_on_cell
    loop do
      puts "Enter the coordinate for your shot:"
      shot = gets.chomp
      if @computer_board.valid_coordinate?(shot)
        @computer_board.cells[shot].fire_upon
        break
      else
        puts "Please enter a valid coordinate."
      end
    end
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    @computer_board.render
    puts "==============PLAYER BOARD=============="
    @player_board.render(true)
  end

  def take_turn
    display_boards
    player_fires_on_cell
    display_boards
  end

  def results
  end

end
