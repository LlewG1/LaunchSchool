def reduce(array, num=0)
  counter = 0
  output = num

  while counter < array.size
    output = yield(output, array[counter])
    counter += 1
  end

  output 
end



array = [1, 2, 3, 4, 5]

puts reduce(array) { |acc, num| acc + num }                    # => 15
puts reduce(array, 10) { |acc, num| acc + num }                # => 25
puts reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass
