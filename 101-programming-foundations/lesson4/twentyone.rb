VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'].freeze
SUITS = ['Hearts', 'Clubs', 'Diamonds', 'Spades'].freeze
score = {player: 0, dealer: 0, ties: 0}

def prompt(message)
  puts "=> #{message}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == "Ace"
      sum += 11
    elsif value.to_i == 0
      sum += 10
    else
      sum += value.to_i
    end
  end

  values.select { |value| value == "Ace" }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def busted?(player_value)
  player_value > 21
end

def detect_result(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > 21
    :player_busted
  elsif dealer_total > 21
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(dealer_cards, player_cards)
  result = detect_result(dealer_cards, player_cards)

  case result
  when :player_busted
    prompt "   -----------------------------"
    prompt "  |   You busted! Dealer wins!  |"
    prompt "   -----------------------------"
  when :dealer_busted
    prompt "   -----------------------------"
    prompt "  |   Dealer busted! You win!   |"
    prompt "   -----------------------------"
  when :player
    prompt "       --------------"
    prompt "      |   You win!   |"
    prompt "       --------------"
  when :dealer
    prompt "      ------------------"
    prompt "     |   Dealer wins!   |"
    prompt "      ------------------"
  when :tie
    prompt "      -----------------"
    prompt "     |   It's a tie!   |"
    prompt "      -----------------"
  end
end

def score_tracking(score, dealer_cards, player_cards)
  result = detect_result(dealer_cards, player_cards)
  case result
  when :player 
    score[:player] += 1
  when :dealer_busted
    score[:player] += 1
  when :dealer
    score[:dealer] += 1
  when :player_busted
    score[:dealer] += 1
  when :tie
    score[:ties] += 1
  end 
end

def play_again?(score)
  return false if score[:player] == 5 || score[:dealer] == 5
  prompt " "
  prompt "Player has #{score[:player]} wins, Dealer has #{score[:dealer]} wins, there have been #{score[:ties]} ties."
  prompt "Ready to play again?"
  prompt "Press (y) to continue or (n) to forfeit"
  answer = gets.chomp
  answer.downcase.start_with?("y")
end

prompt "Welcome to Twenty-One!"
prompt "The aim of the game is to get 5 wins"
prompt "If the dealer gets 5 wins, you lose!"
prompt "Goodluck"
sleep 3

loop do
  system 'clear' or system 'cls'

  deck = initialize_deck
  player_cards = []
  dealer_cards = []


  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end
  
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  prompt "------------------------------------------- "
  prompt "Dealer has #{dealer_cards[0]} and an unknown card"
  prompt "You have: #{player_cards[0]} and #{player_cards[1]}, for a total of #{total(player_cards)}."

  loop do
    player_turn = nil
    loop do
      prompt "Would you like to (h)it or (s)tay?"
      player_turn = gets.chomp.downcase
      break if ['h', 's'].include?(player_turn)
      prompt "Please enter either 'h' or 's'."
    end

    if player_turn == 'h'
      player_cards << deck.pop
      player_total = total(player_cards)
      prompt "You chose to hit!"
      prompt "------------------------------------------- "
      prompt "Your cards are now: #{player_cards}"
      prompt "Your total is now: #{player_total}"
    end

    break if player_turn == 's' || busted?(player_total)
  end

  if busted?(player_total)
    display_result(dealer_cards, player_cards)
    score_tracking(score, dealer_cards, player_cards)
    play_again?(score) ? next : break
  else
    prompt "You stay at #{player_total}"
    prompt "------------------------------------------- "
  end

  prompt "Dealer turn..."
  prompt " "
  prompt "Dealer has: #{dealer_cards[0]} and #{dealer_cards[1]}, for a total of #{dealer_total}."

  loop do
    break if dealer_total >= 17
    dealer_cards << deck.pop
    dealer_total = total(dealer_cards)

    prompt "Dealer has hit and has cards #{dealer_cards}"
    prompt "Dealer total is now #{dealer_total}"
    prompt " "
  end

  if busted?(dealer_total)
    display_result(dealer_cards, player_cards)
    score_tracking(score, dealer_cards, player_cards)
    play_again?(score) ? next : break
  else
    prompt "Dealer stays at #{dealer_total}"
    prompt "------------------------------------------- "
  end

  score_tracking(score, dealer_cards, player_cards)
  display_result(dealer_cards, player_cards)

  break unless play_again?(score)
end

prompt ""

if score[:dealer] == 5
  prompt " Tough luck, you lost 5 games!"
elsif score[:player] == 5
  prompt "Congratulations, you won 5 times and are officially Twenty-One Champion!"
end

prompt ""
prompt "Thanks for playing!"
