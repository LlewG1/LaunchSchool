puts 'Enter your year'
year = gets.chomp
year = year.to_i
puts 'Enter your month'
month = gets.chomp
month = month.to_i
puts 'Enter your day'
day = gets.chomp
day = day.to_i
birth1 = Time.mktime(year, month, day)
age1 = Time.new - birth1
age1 = (age1.to_i)/60/60/24/365
puts 'You are ' + age1.to_s + ' years old!'
