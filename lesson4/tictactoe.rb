    # Tic Tac Toe by Llew Griffith

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

    # Format methods

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(array, middle=', ', word='or')
  array[-1] = "#{word} #{array.last}" if array.size > 1
  array.join(middle)
end

    # Board setup methods

def display_board(brd)
  system 'clear' or system 'cls'
  prompt "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}. First to 5 wins!"
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----|-----|-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----|-----|-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def alternate_player(current_player)
    if current_player == 'Computer'
      return 'Player'
    elsif current_player == 'Player'
      return 'Computer'
    end
end

    # Initial user prompts

def game_difficulty
  prompt "Would you like to play 'easy' or dare to play 'hard'?"
  prompt "Noobs press (e) for easy, pros press (h) for hard"
  return gets.chomp
end

def turn_choice
  prompt "Would you like to go first or second?"
  prompt "Press (f) for sissy first turn or (s) to play like a boss and let computer go first"
  turn_answer = gets.chomp
  
  if turn_answer.downcase.start_with?('f')
    return 'Player'
  elsif turn_answer.downcase.start_with?('s')
    return 'Computer'
  end
end

    # Gameplay methods

def place_piece!(board, current_player, difficulty_answer)
  if current_player == 'Computer'
    computer_places_piece!(board, difficulty_answer)
  elsif current_player == 'Player'
    player_places_piece!(board)
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a position to place a piece (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice"
  end
  brd[square] = PLAYER_MARKER
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select{|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  else
    nil
  end
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def computer_places_piece!(brd, difficulty_answer)
  square = nil
  WINNING_LINES.each do |line|
      if difficulty_answer.downcase.start_with?('h')
        square = find_at_risk_square(line, brd, COMPUTER_MARKER)
        break if square
      end
    end
    
    if !square 
      WINNING_LINES.each do |line|
        square = find_at_risk_square(line,brd, PLAYER_MARKER)
        break if square 
      end
    end
    
    if !square && difficulty_answer.downcase.start_with?('h')
      square = 5 if brd[5] == INITIAL_MARKER
    end
    
    if !square
      square = empty_squares(brd).sample
    end
    
    brd[square] = COMPUTER_MARKER
end

    # Game end detection methods

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

    # Post game messages and score tracking 

def winning_messages(board)
  if someone_won?(board)
    display_board(board)
    prompt "#{detect_winner(board)} won!"
  elsif board_full?(board)
    display_board(board)
    prompt "It's a tie"
  end
  
end

def display_game_score(board, score) 
  if board_full?(board) || someone_won?(board)
    prompt "Player has #{score[:player_wins]} wins, Computer has #{score[:computer_wins]} wins, there have been #{score[:ties]} ties."
  end
end

def win_conditions(score)
  if score[:player_wins] == 5
    prompt "Player has taken the best of 5 win!"
    return true
  elsif score[:computer_wins] == 5
    prompt "Computer has taken the best of 5 win!"
    return true
  end
end

def score_tracking(score, board)
  if detect_winner(board) == 'Player'
    score[:player_wins] += 1
  elsif detect_winner(board) == 'Computer'
    score[:computer_wins] += 1
  elsif board_full?(board)
    score[:ties] += 1
  end 
end

def continue_playing(board, score)
  if detect_winner(board) || board_full?(board)
    game_number = score[:player_wins] + score[:computer_wins] + score[:ties] + 1
    prompt "Ready for game number #{game_number}? Hit any key to continue or (n) to forfeit!"
    answer = gets.chomp
    true if answer.downcase.start_with?('n')
  end  
end

    # Reset methods

def reset_player(current_player, first_turn, board)
  if board_full?(board) || someone_won?(board)
    return first_turn
  else
    return current_player
  end
end

def reset_board(board)
  if board_full?(board) || someone_won?(board)
    return initialize_board
  else
    return board
  end
end

    # Program

score = { player_wins: 0, computer_wins: 0, ties: 0 } 

difficulty_answer = game_difficulty
first_turn = turn_choice

current_player = first_turn
board = initialize_board

loop do
 
  display_board(board)
  
  # Gameplay
  place_piece!(board, current_player, difficulty_answer)
  current_player = alternate_player(current_player)
  
  # Post game messages and score tracking
  winning_messages(board)
  score_tracking(score, board)  
  display_game_score(board, score)

  # End game if forfeit or 5 wins
  break if win_conditions(score)
  break if continue_playing(board, score)
  
  # Reset gameboard
  current_player = reset_player(current_player, first_turn, board)
  board = reset_board(board)

end

prompt "Thanks for playing Tic Tac Toe!"
