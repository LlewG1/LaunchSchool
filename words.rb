#Write a program which asks us to type in as many words as we want (one word per line, continuing until we just press Enter on an empty line), and which then repeats the words back to us in alphabetical order.
array = []
new = 'a'
while new != ''
    new = gets.chomp
    new = new.downcase
    array.push new
end
puts array.sort