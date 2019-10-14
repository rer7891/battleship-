require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @cell_1 = @board.cells["A1"]
    @cell_2 = @board.cells["A2"]
    @cell_3 = @board.cells["A3"]
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_has_cells
    assert_instance_of Hash, @board.cells
  end

  def test_it_is_a_valid_coordinate
    assert_equal true, @board.valid_coordinate?("A2")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_if_validate_length
    assert_equal false, @board.validate_placement?(@cruiser, ["A6", "A2"])
    assert_equal false, @board.validate_placement?(@submarine, ["A2", "A3", "A4"])
    assert_equal true, @board.validate_placement?(@cruiser, ["A1", "A2", "A3"])
  end

  def test_it_validates_consecutive
    assert_equal false, @board.validate_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.validate_placement?(@submarine, ["A1", "C1"])
    assert_equal false, @board.validate_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.validate_placement?(@submarine, ["C1", "B1"])
    assert_equal false, @board.validate_placement?(@cruiser, ["A1", "A1", "A1"])
    assert_equal true, @board.validate_placement?(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.validate_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.validate_placement?(@cruiser, ["A1", "B22", "C3"])
  end

  def test_it_validates_diagonal
    assert_equal false, @board.validate_placement?(@cruiser, ["A1", "B2", "C4"])
    assert_equal false, @board.validate_placement?(@submarine, ["C2", "D3"])
    assert_equal true, @board.validate_placement?(@submarine, ["A1", "A2"])
    assert_equal true, @board.validate_placement?(@cruiser, ["B1", "C1", "D1"])

  end

  def test_it_can_place_a_ship

    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal @cruiser, @cell_1.ship
    assert_equal @cruiser, @cell_2.ship
    assert_equal @cruiser, @cell_3.ship
    assert @cell_3.ship == @cell_2.ship
  end

  def test_it_does_not_overlap_placed_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.validate_placement?(@submarine, ["A1", "B1"])
    assert_equal false, @board.validate_placement?(@submarine, ["A2", "A3"])
   end

  def test_it_renders_a_board_without_ship
    assert_equal " ", @board.render
    # "A . . . . \n" +
    # "B . . . . \n" +
    # "C . . . . \n" +
    # "D . . . . \n", @board.render
   end

  def test_it_renders_a_board_with_ship
skip
     assert_equal "  1 2 3 4 \n" +
    "A S S S . \n" +
    "B . . . . \n" +
    "C . . . . \n" +
    "D . . . . \n", @board.render
  end
end
