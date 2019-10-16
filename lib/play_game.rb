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
      @player_shot = gets.chomp
      if @computer_board.cells[@player_shot].fired_upon?
        puts "You have already fired on this coordinate."
        puts "Please enter a valid coordinate."
      elsif @computer_board.valid_coordinate?(@player_shot)
        @computer_board.cells[@player_shot].fire_upon
        break
      else
        puts "Please enter a valid coordinate."
      end
    end
  end

  def computer_fires_shot
    cell_collection = @player_board.cells.keys

    @computer_shot = cell_collection.sample(1)

    @player_board.cells[@computer_shot[0]].fire_upon
    cell_collection.delete(@computer_shot)
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    @computer_board.render
    puts "==============PLAYER BOARD=============="
    @player_board.render(true)
  end

  def display_player_results
    if @computer_board.cells[@player_shot].render == "M"
      puts "Your shot on #{@player_shot} was a miss."
    elsif @computer_board.cells[@player_shot].render == "H"
      puts "Your shot on #{@player_shot} was a hit."
    elsif @computer_board.cells[@player_shot].render == "X"
        puts "Your shot on #{@player_shot} sunk my ship."
    end
  end

  def display_computer_results
    if @player_board.cells[@computer_shot[0]].render == "M"
      puts "My shot on #{@computer_shot[0]} was a miss."

    elsif @player_board.cells[@computer_shot[0]].render == "H"
      puts "My shot on #{@computer_shot[0]} was a hit."
    elsif @player_board.cells[@computer_shot[0]].render == "X"
        puts "My shot on #{@computer_shot[0]} sunk my ship."
    end
  end

  def take_turn
   until @computer_ship_1.sunk? && @computer_ship_2.sunk? || @user_ship_1.sunk? && @user_ship_2.sunk?
    player_fires_on_cell
      computer_fires_shot
      display_boards
      display_player_results
      display_computer_results
      display_boards
   end
   results
  end

  def results
    if  @computer_ship_1.sunk? && @computer_ship_2.sunk?
      puts "You win"
    else
      puts "You lose"
    end
    start_game
  end

end
