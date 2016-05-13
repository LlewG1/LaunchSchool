def numbers(num)
  yield
  puts num
end

numbers(10) { puts "numbers!" }