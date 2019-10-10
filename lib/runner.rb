require './lib/ship'
require './lib/cell'
@cell = Cell.new("B4")
@cruiser = Ship.new("Cruiser", 3)
@board = Board.new

@board.validate_placement(@cruiser, ["A1", "A2", "A3"])
