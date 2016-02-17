puts 'Please enter a number for a ditsy tune!'
number = gets.chomp

def englishNumber number
  if number < 0  # No negative numbers.
    return 'Please enter a number that isn\'t negative.'
  end
  if number == 0
    return 'zero'
  end

  # No more special cases! No more returns!

  numString = ''  # This is the string we will return.

  onesPlace = ['one',     'two',       'three',    'four',     'five',
               'six',     'seven',     'eight',    'nine']
  tensPlace = ['ten',     'twenty',    'thirty',   'forty',    'fifty',
               'sixty',   'seventy',   'eighty',   'ninety']
  teenagers = ['eleven',  'twelve',    'thirteen', 'fourteen', 'fifteen',
               'sixteen', 'seventeen', 'eighteen', 'nineteen']

  # "left" is how much of the number we still have left to write out.
  # "write" is the part we are writing out right now.
  # write and left... get it?  :)
  left  = number
  
  write = left/100000
  left = left - write*100000

  if write > 0
    
    hundthousands = englishNumber write
    numString = numString + hundthousands + ' hundred'

     if left > 0
       numString = numString + ' '
     end
  end
  
  write = left/1000
  left = left - write*1000

  if write > 0
    
    thousands = englishNumber write
      if 
        numString = numString + thousands + ' thousand'
      end
      
      if left > 0
        numString = numString + ' '
      end
  end
  
  write = left/100          # How many hundreds left to write out?
  left  = left - write*100  # Subtract off those hundreds.
  
  if write > 0 
    
    hundreds  = englishNumber write
    numString = numString + hundreds + ' hundred'

    if left > 0
      numString = numString + ' '
    end
  end

  write = left/10          # How many tens left to write out?
  left  = left - write*10  # Subtract off those tens.

  if write > 0
    if ((write == 1) and (left > 0))
      numString = numString + teenagers[left-1]
      left = 0
    else
      numString = numString + tensPlace[write-1]
    end

    if left > 0
      numString = numString + '-'
    end
  end

  write = left  # How many ones left to write out?
  left  = 0     # Subtract off those ones.

  if write > 0
    numString = numString + onesPlace[write-1]
  end
  
  numString
  
end

while number.to_i > 0 
  if number.to_i > 1 
    puts englishNumber(number.to_i).capitalize + ' bottles of beer on the wall,' 
    puts englishNumber(number.to_i).capitalize + ' bottles of beer!' 
    puts 'Take one down,'
    puts 'Pass it around,'
    number = number.to_i - 1 
    if number.to_i > 1 
      puts englishNumber(number.to_i).capitalize + ' bottles of beer on the wall!'
      puts ''
    else
       puts englishNumber(number.to_i).capitalize + ' bottle of beer on the wall!'
       puts ''
    end
  else 
    puts englishNumber(number.to_i).capitalize + ' bottle of beer on the wall,' 
    puts englishNumber(number.to_i).capitalize + ' bottle of beer!' 
    puts 'Take one down,'
    puts 'Pass it around,'
    number = number.to_i - 1 
    puts 'No bottles of beer on the wall!'
    puts ''
  end
end 

