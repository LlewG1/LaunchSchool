VALID_CHOICES = %w(rock paper scissors lizard spock)
SHORT_CHOICES = %w(r p sc l sp)

def prompt(message)
  Kernel.puts("=>#{message}")
end

def win?(first, second)
  (first == 'rock' && (second == 'scissors' || second == 'lizard')) ||
  (first == 'paper' && (second == 'rock' || second == 'spock')) ||
  (first == 'scissors' && (second == 'paper' || second == 'lizard')) ||
  (first == 'spock' && (second == 'rock' || second == 'scissors')) ||
  (first == 'lizard' && (second == 'spock' || second == 'paper'))
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

loop do
  choice = ''
  element_number = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice) 
      break
    elsif SHORT_CHOICES.include?(choice)
      element_number = SHORT_CHOICES.index(choice)
      choice = VALID_CHOICES[element_number.to_i]
      break
    else
      prompt("Thats not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{VALID_CHOICES[element_number.to_i]}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thankyou for playing!")