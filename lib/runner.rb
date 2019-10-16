require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/play_game'

@cruiser = Ship.new("Cruiser", 3)
@play = BattleShip.new
@play.start_game
