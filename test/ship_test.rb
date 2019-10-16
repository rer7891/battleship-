require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_it_has_a_name
    assert_equal "Cruiser", @cruiser.name
  end

  def test_it_has_a_length
    assert_equal 3, @cruiser.length
  end

  def test_it_has_health
    assert_equal 3, @cruiser.health
  end

  def test_it_starts_not_sunk
    refute @cruiser.sunk?
  end

  def test_health_once_its_hit
    @cruiser.hit
    assert_equal 2, @cruiser.health
  end

  def test_it_can_be_hit
    2.times do
      @cruiser.hit
    end
    assert_equal false, @cruiser.sunk?
  end

  def test_it_can_be_sunk
      @cruiser.hit
      @cruiser.hit
      @cruiser.hit
    assert_equal true, @cruiser.sunk?
  end
end
