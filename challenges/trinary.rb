  # First Pass

# class Trinary
#   def initialize(number)
#     @num = number =~ /[a-zA-Z]/? '0' : number
#   end
  
#   def to_decimal
#     total = 0
#     @num.chars.each_with_index do |digit, idx|
#       total += digit.to_i * 3 ** (line.length - (idx + 1))
#     end
#     total
#   end
# end

  # Refactor 1

class Trinary
  def initialize(number)
    @num = number =~ /[a-zA-Z]/? '0' : number
  end
  
  def to_decimal
    @num.chars.reverse.each_with_index.map do |digit, idx| 
      digit.to_i * 3 ** idx 
    end
    .reduce(:+)
  end
end
