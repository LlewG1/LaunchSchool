require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'car'

  # Chapter 3
  
# class CarTest < MiniTest::Test
#   def test_wheels
#     car = Car.new
#     assert_equal(4, car.wheels)
#   end

#   def test_bad_wheels
#     skip                            # 'skip' skips the current test
#     car = Car.new
#     assert_equal(3, car.wheels)
#   end
# end

  # Chapter 4

# class CarTest < MiniTest::Test
#   def test_car_exists
#     car = Car.new
#     assert(car)
#   end
  
#   def test_wheels
#     car = Car.new
#     assert_equal(4, car.wheels)
#   end
  
#   def test_name_is_nil
#     car = Car.new
#     assert_nil(car.name)
#   end
  
#   def test_raise_initialize_with_arg
#     assert_raises(ArgumentError) do
#       car = Car.new(name: "Joey")
#     end
#   end
  
#   def test_instance_of_car
#     car = Car.new
#     assert_instance_of(Car, car)
#   end
  
#   def test_includes_car
#     car = Car.new
#     arr = [1, 2, 3]
#     arr << car
    
#     assert_includes(arr, car)
#   end
# end

  # Chapter 5
  
    #  SEAT Approach: 4 steps to writing a test:
    
    # Set up the necessary objects.
    # Execute the code against the object we're testing.
    # Assert the results of the execution.
    # Tear down and clean up any lingering artifacts.
  
class CarTest < MiniTest::Test
  def setup 
    @car = Car.new
  end
  
  def test_car_exists
    assert(@car)
  end
  
  def test_wheels
    assert_equal(4, @car.wheels)
  end
  
  def test_name_is_nil
    assert_nil(@car.name)
  end
  
  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      car = Car.new(name: "Joey")
    end
  end
  
  def test_instance_of_car
    assert_instance_of(Car, @car)
  end
  
  def test_includes_car
    arr = [1, 2, 3]
    arr << @car
    
    assert_includes(arr, @car)
  end
end