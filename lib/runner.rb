require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/play_game'

@cell = Cell.new("B4")
@cruiser = Ship.new("Cruiser", 3)
@board = Board.new
@play = BattleShip.new(@board)

@play.start_game




# (A..D).each {|letter| letter + 1)
#   # (1..4).each do {|number| number + }
# end
