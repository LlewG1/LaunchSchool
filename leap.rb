puts 'Please enter a start year'
year1 = gets.chomp
puts 'Please enter an end year'
year2 = gets.chomp
puts 'Leap years are as follows:'
while year1.to_i != year2.to_i + 1
    if year1.to_i%4 == 0 and  year1.to_i%100 != 0
        puts year1
        year1 = year1.to_i + 1
    else 
        if year1.to_i%400 == 0 
          puts year1
          year1 = year1.to_i + 1
        else
          year1 = year1.to_i + 1
        end
    end
end