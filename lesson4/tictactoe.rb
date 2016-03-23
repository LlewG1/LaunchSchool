    # Tic Tac Toe by Llew Griffith

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]].freeze

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
    'Player'
  elsif current_player == 'Player'
    'Computer'
  end
end

    # Initial user prompts

def game_difficulty
  answer = ''
  loop do
    prompt "Would you like to play 'easy' or dare to play 'hard'?"
    prompt "Noobs press (e) for easy, pros press (h) for hard"
    answer = gets.chomp
    break if answer.downcase.start_with?('e') || answer.downcase.start_with?('h')
    prompt "Sorry, that's not a valid choice"
  end
  answer
end

def turn_choice
  turn_answer = ''
  loop do
    prompt "Would you like to go first or second?"
    prompt "Press (f) for first turn or (s) to play like a boss and let computer go first"
    turn_answer = gets.chomp
    break if turn_answer.downcase.start_with?('f') || turn_answer.downcase.start_with?('s')
    prompt "Sorry, that's not a valid choice"
  end

  if turn_answer.downcase.start_with?('f')
    'Player'
  elsif turn_answer.downcase.start_with?('s')
    'Computer'
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
    board.select{|piece,empty_square| line.include?(piece) && empty_square == INITIAL_MARKER}.keys.first
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

def overall_win_messages(score)
  if score[:player_wins] == 5
    prompt "Player has taken the best of 5 win!"
  elsif score[:computer_wins] == 5
    prompt "Computer has taken the best of 5 win!"
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

def stop_playing?(board, score)
  if detect_winner(board) || board_full?(board)
    game_number = score[:player_wins] + score[:computer_wins] + score[:ties] + 1
    prompt "Ready for game number #{game_number}? Hit any key to continue or (n) to forfeit!"
    answer = gets.chomp
    answer.downcase.start_with?('n')
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
  
  overall_win_messages(score)
  break if score[:player_wins] == 5 || score[:computer_wins] == 5
  break if stop_playing?(board, score)
  
  # Reset gameboard

  if board_full?(board) || someone_won?(board)
    current_player = first_turn
    board = initialize_board
  end

end

prompt "Thanks for playing Tic Tac Toe!"
