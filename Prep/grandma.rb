command = ''
while command != 'BYE'
  command = gets.chomp
  date = 1930 + rand(21)
  if command != command.upcase
      puts 'HUH? SPEAK UP SON'
  else 
      if command != 'BYE'
        puts 'NO, NOT SINCE ' + date.to_s
      end
  end
end
puts 'BYE SONNY'
