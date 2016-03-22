# 1. Initialize deck
# 2. Deal cards to player and dealer
# 3. Player turn: hit or stay
#   - repeat until bust or "stay"
# 4. If player bust, dealer wins.
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.

def prompt(message)
  puts "=> #{message}"
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
  
  values.select { |value| value == "Ace"}.count.times do
    sum -= 10 if sum > 21
  end
  
  sum
end

def busted?(player_value)
  player_value > 21
end

cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']
suit = ['Heart', 'Club', 'Diamond', 'Spade']
deck = suit.product(cards)

loop do

player_cards = deck.sample(1)
deck = deck - player_cards 
dealer_cards = deck.sample(2)
deck = deck - dealer_cards

player_value = total(player_cards)
dealer_value = total(dealer_cards)
answer = nil



  loop do
    player_cards += deck.sample(1)
    deck -= player_cards  
    player_value = total(player_cards)
    break if busted?(player_value)
    prompt "Your cards are #{player_cards}"
    prompt "Your current total is #{player_value}"
    prompt "Press (enter) to 'hit' or (s) to 'stay'"
    answer = gets.chomp
    break if answer.downcase.start_with?("s")
  end
  
  if busted?(player_value)
    prompt "Your cards are #{player_cards}"
    prompt "Your current total is #{player_value}"
    prompt 'Busted! You lose!'
  else
    prompt 'You chose to stay!'
  end
  
  if !busted?(player_value)
    prompt "Dealer has pulled #{dealer_cards}"
    prompt "Dealer value is #{dealer_value}"
  
    loop do
      break if dealer_value >= 17
      dealer_cards += deck.sample(1)
      deck -= dealer_cards  
      dealer_value = total(dealer_cards)
      prompt "Dealer has hit and has cards #{dealer_cards}"
      prompt "Dealer total is #{dealer_value}"
    end
    
    if busted?(dealer_value)
      prompt "Dealer has busted!"
    elsif dealer_value >= player_value
      prompt "House has won!"
    elsif player_value > dealer_value
      prompt "You win!"
    end
  end

  prompt "Would you like to play again?"
  prompt "Press (enter) to continue or (n) to quit"
  answer = gets.chomp
  break if answer.downcase.start_with?("n")

end
prompt "Thanks for playing"




