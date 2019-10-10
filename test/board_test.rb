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

  def test_it_validate_hortizontal
  end

end
