class PlayBattleShip
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

  def setup_game
   p @board.render
  end

  def take_turn
  end

  def results
  end

end
