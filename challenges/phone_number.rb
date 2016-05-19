  # First pass

class PhoneNumber
  
  def initialize(number)
    @phone_number = number
  end
  
  def number
    number = @phone_number.chars.select{|num| ('0'..'9').include? num }
    
    if number.first == '1' && number.length == 11
      number.shift
    end
    if number.length != 10
      return '0' * 10
    end
    @phone_number.chars.map do |digit| 
      return '0' * 10 if ('a'..'z').include? digit 
    end
    
    number.join
  end
  
  def area_code
    number.chars.first(3).join
  end
  
  def to_s
    "(#{area_code}) #{number.chars[3..5].join}-#{number.chars[6..9].join}"
  end
end

  # Refactor 1
  
class PhoneNumber
  def initialize(number)
    @num = number =~ /[a-zA-Z]/? '' : number.gsub(/\D/, '')
  end
  
  def number
    valid = (@num[0] == '1' && @num.length == 11) || @num.length == 10
    valid ? @num[-10..-1] : '0000000000'
  end
  
  def area_code
    number[0..2]
  end
  
  def to_s
    "(#{area_code}) #{number[3..5]}-#{number[6..9]}"
  end
end

