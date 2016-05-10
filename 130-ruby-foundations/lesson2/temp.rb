  # Chapter 2

# require 'minitest/autorun'

# class MyFirstTest < Minitest::Test
#   def test_first_test
#     assert true
#   end
# end

  # Chapter 6
  
require 'minitest/autorun'

class EqualityTest < Minitest::Test
  def test_value_equality
    str1 = "hi there"
    str2 = "hi there"

    assert_equal(str1, str2)
    assert_same(str1, str2)
  end
end