require 'minitest/autorun'

  # Chapter 3 - 5

# class Car
#   attr_accessor :wheels

#   def initialize
#     @wheels = 4
#   end
# end

  # Chapter 6 
  
class Car
  attr_accessor :wheels, :name

  def initialize
    @wheels = 4
  end
  
  def ==(other)                       # assert_equal would fail without this method
    other.is_a?(Car) && name == other.name
  end
end

class CarTest < MiniTest::Test
  def test_value_equality
    car1 = Car.new
    car2 = Car.new

    car1.name = "Kim"
    car2.name = "Kim"

    assert_equal(car1, car2)
    assert_same(car1, car2)           # this will fail
  end
end