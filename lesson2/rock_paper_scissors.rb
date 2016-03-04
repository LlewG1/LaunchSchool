VALID_CHOICES = %w(rock paper scissors lizard spock)
SHORT_CHOICES = %w(r p sc l sp)

def prompt(message)
  Kernel.puts("=>#{message}")
end

def win?(first, second)
  (first == 'rock' && second == ('scissors' || 'lizard')) ||
    (first == 'paper' && second == ('rock' || 'spock')) ||
    (first == 'scissors' && second == ('paper' || 'lizard')) ||
    (first == 'spock' && second == ('rock' || 'scissors')) ||
    (first == 'lizard' && second == ('spock' || 'paper'))
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

user_wins = ''
computer_wins = ''
ties = ''

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice) || SHORT_CHOICES.include?(choice)
      break
    else
      prompt("Thats not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample
  element_number = SHORT_CHOICES.index(choice)
  
  prompt("You chose: #{VALID_CHOICES[element_number]}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thankyou for playing!")