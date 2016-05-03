# frozen_string_literal: true
# rubocop:disable Metrics/AbcSize

class Board
  attr_reader :squares
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def draw
    puts ""
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
    puts ""
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_squares
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_squares.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if identical_markers?(squares, 3)
    end
    nil
  end

  def find_at_risk_square(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if identical_markers?(squares, 2, marker)
        return line.find { |num| @squares[num].marker == Square::EMPTY_MARKER }
      end
    end
    nil
  end

  private

  def identical_markers?(squares, marker_count, opp_mark=nil)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != marker_count
    return false if marker_count == 2 && markers.min != opp_mark

    markers.min == markers.max
  end
end

class Square
  attr_accessor :marker
  EMPTY_MARKER = " "

  def initialize(marker=EMPTY_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == EMPTY_MARKER
  end

  def marked?
    marker != EMPTY_MARKER
  end
end

class Player
  attr_accessor :marker, :name

  def initialize
    choose_name
    choose_marker
  end
end

class Human < Player
  def choose_name
    answer = ""
    loop do
      puts "Hi, what's your name?"
      answer = gets.chomp.capitalize
      break unless answer.empty?
      puts "Sorry, must enter a name."
    end
    self.name = answer
  end

  def choose_marker
    answer = ''
    loop do
      puts "Please choose any single letter to be your marker"
      answer = gets.chomp.upcase
      break if (('A'..'Z').to_a.include? answer) && (answer.length == 1)
      puts "Sorry, that's not a valid choice"
    end
    self.marker = answer
  end
end

class Computer < Player
  def choose_name
    self.name = ['R2D2', 'C3PO', 'BB-8'].sample
  end

  def choose_marker
    self.marker = 'X'
  end
end

class TTTGame
  attr_reader :board, :human, :computer, :score

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @current_marker = human.marker
    @score = { human_wins: 0, computer_wins: 0, ties: 0 }
  end

  def play
    initial_input_and_display

    loop do
      board.draw
      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end
      clear_screen
      display_result_score_and_update
      break if overall_win?
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

  private

  def initial_input_and_display
    adjust_computer_marker
    choose_first_turn
    clear_screen
    display_welcome_message
    sleep 2
  end

  def display_welcome_message
    puts ""
    puts "       Welcome #{human.name} to Tic Tac Toe!"
    puts "Your opponent today is the very skilled #{computer.name}"
    puts "        First player to 5 wins"
    puts "               Goodluck!"
  end

  def adjust_computer_marker
    computer.marker = 'O' if human.marker == 'X'
  end

  def choose_first_turn
    answer = ''
    loop do
      puts "Would you like to go first or second?"
      puts "Enter 'f' or 's'"
      answer = gets.chomp.downcase
      break if %w(f s).include? answer
      puts "Sorry, that's not a valid choice"
    end
    @current_marker = human.marker if answer == 'f'
    @current_marker = computer.marker if answer == 's'
  end

  def clear_screen_and_display_board
    clear_screen
    board.draw
  end

  def joinor(array)
    array[-1] = "or #{array.last}" if array.size > 1
    array.join(', ')
  end

  def human_moves
    square = nil
    puts "Choose a square: #{joinor(board.unmarked_squares)}"
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_squares.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    if board.find_at_risk_square(computer.marker)
      board[board.find_at_risk_square(computer.marker)] = computer.marker
    elsif board.find_at_risk_square(human.marker)
      board[board.find_at_risk_square(human.marker)] = computer.marker
    elsif board.unmarked_squares.include?(5)
      board[5] = computer.marker
    else
      board[board.unmarked_squares.sample] = computer.marker
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def display_result
    board.draw

    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_result_score_and_update
    display_result
    update_score
    display_score
  end

  def update_score
    case board.winning_marker
    when human.marker
      score[:human_wins] += 1
    when computer.marker
      score[:computer_wins] += 1
    else
      score[:ties] += 1
    end
  end

  def display_score
    puts "The score is #{score[:human_wins]} wins for #{human.name}, "\
         "#{score[:computer_wins]} wins for #{computer.name}, and "\
         "#{score[:ties]} ties. "
  end

  def overall_win?
    if score[:human_wins] == 5
      display_overall_win(human.name)
      return true
    elsif score[:computer_wins] == 5
      display_overall_win(computer.name)
      return true
    end
  end

  def display_overall_win(player)
    puts "#{player} won best of 5!"
    puts ""
  end

  def play_again?
    answer = nil
    loop do
      puts "Ready to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def reset
    board.reset
    @current_marker = human.marker
    clear_screen
    puts "Lets play again!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing tic tac toe!"
  end
end

game = TTTGame.new
game.play
