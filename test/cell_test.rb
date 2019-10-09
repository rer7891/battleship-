require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup

    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists

    assert_instance_of Cell, @cell
  end

  def test_it_has_a_coordinate
    assert_equal "B4", @cell.coordinate
  end

  def test_it_starts_empty
    assert_equal nil, @cell.ship
    assert_equal true, @cell.empty?
    assert_equal ".", @cell.render
  end

  def test_it_can_add_a_ship
    @cell.place_ship(@cruiser)

    assert_equal @cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_it_can_fire_when_empty
    refute  @cell.fired_upon?
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
  end

  def test_it_can_be_fired_on
    @cell.place_ship(@cruiser)
    refute false, @cell.fired_upon?
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
    assert_equal true, @cell.fired_upon?
  end

  def test_it_can_change_render_output
    assert_equal ".", @cell.render
    @cell.fire_upon
    @cell.fired_upon?
    assert_equal "M", @cell.render
  end

  def test_it_can_be_hit
    @cell.place_ship(@cruiser)
    assert_equal ".", @cell.render
    @cell.fire_upon
    @cell.fired_upon?
    assert_equal "H", @cell.render
  end

  def test_it_can_render_ship
    @cell.place_ship(@cruiser)
    assert_equal ".", @cell.render
    assert_equal "S", @cell.render(true)
  end

  def test_it_can_render_a_hit
    @cell.place_ship(@cruiser)
    assert_equal "S", @cell.render(true)
    @cell.fire_upon
    assert_equal "H", @cell.render
    assert_equal false, @cruiser.sunk?
  end

  def test_it_can_be_sunk
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    @cruiser.hit
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    assert_equal true, @cruiser.sunk?
  end
end
