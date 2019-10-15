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
    @cell_A1 = @board.cells["A1"]
    @cell_A2 = @board.cells["A2"]
    @cell_A3 = @board.cells["A3"]
    @cell_C3 = @board.cells["C3"]
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
    assert_equal true, @board.validate_placement?(@submarine, ["B1", "B2"])
  end

  def test_it_validates_diagonal
    assert_equal false, @board.validate_placement?(@cruiser, ["A1", "B2", "C4"])
    assert_equal false, @board.validate_placement?(@submarine, ["C2", "D3"])
    assert_equal true, @board.validate_placement?(@submarine, ["A1", "A2"])
    assert_equal true, @board.validate_placement?(@cruiser, ["B1", "C1", "D1"])

  end

  def test_it_can_place_a_ship

    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal @cruiser, @cell_A1.ship
    assert_equal @cruiser, @cell_A2.ship
    assert_equal @cruiser, @cell_A3.ship
    assert @cell_A3.ship == @cell_A2.ship
  end

  def test_it_does_not_overlap_placed_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.validate_placement?(@submarine, ["A1", "B1"])
    assert_equal false, @board.validate_placement?(@submarine, ["A2", "A3"])
  end

  def test_it_can_render_board
    assert_equal ".", @cell_A1.render
  end

  def test_it_render_cell_with_ship
    @board.render
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal "S", @cell_A1.render(true)
  end

  def test_it_can_render_hit
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @cell_A1.fire_upon
    assert_equal "H", @cell_A1.render
  end

  def test_it_can_render_miss_ship
    @cell_C3.fire_upon
    assert_equal "M", @cell_C3.render
  end

  def test_it_can_render_sunk_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @cell_A1.fire_upon
    @cell_A2.fire_upon
    @cell_A3.fire_upon
    assert_equal "X", @cell_A1.render
    assert_equal "X", @cell_A2.render
    assert_equal "X", @cell_A3.render
  end
end
