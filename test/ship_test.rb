require 'minitest/autorun'
require 'minitest/pride'
require './lib.ship.rb'

class ShipTest < Minitest::Test

  def test_it_exists
    cruiser = Ship.new("Cruiser", 3)
    assert_instance_of Ship, cruiser
  end
  def test_it_has_a_name
  end
  def test_it_has_a_length
  end
end
