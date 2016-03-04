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
    prompt("You won this round!")
    @user_wins = @user_wins + 1 
  elsif win?(computer, player)
    prompt("Computer won this round!")
    @computer_wins = @computer_wins + 1
  else
    prompt("It's a tie!")
    @ties = @ties + 1
  end
end

@user_wins = 0
@computer_wins = 0
@ties = 0
  
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

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  if @user_wins == 5
    prompt("You won!")
    break
  elsif @computer_wins == 5
    prompt("Computer won!")
    break
  end
  prompt("You have #{@user_wins} wins")
  prompt("Computer has #{@computer_wins} wins")
  prompt("There have been #{@ties} ties")
end

prompt("Thankyou for playing!")