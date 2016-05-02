require 'pry'

class Board
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
  
  def unmarked_keys
    @squares.keys.select {|key| @squares[key].unmarked? }
  end
  
  def full?
    unmarked_keys.empty?
  end
  
  def someone_won?
    !!winning_marker
  end
  
  def reset
    (1..9).each {|key| @squares[key] = Square.new}
  end
  
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end
  
  private
  
  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end
end

class Square
  attr_accessor :marker
  INITIAL_MARKER = " "
  
  def initialize(marker=INITIAL_MARKER)
    @marker = marker 
  end
  
  def to_s
    @marker
  end
  
  def unmarked?
    marker == INITIAL_MARKER
  end
  
  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  
  def initialize(marker)
    @marker = marker
  end


end

class TTTGame
  attr_reader :board, :human, :computer
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = HUMAN_MARKER
  
  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end
  
  def play
    display_welcome_message
    clear_screen
    
    loop do
      board.draw
      
      loop do
        human_moves
        break if board.someone_won? || board.full?
        
        computer_moves
        break if board.someone_won? || board.full?
        
        clear_screen_and_display_board
      end
      clear_screen
      display_result
      break unless play_again?
      reset
    end
    
    display_goodbye_message
  end
  
  private
  
  def display_welcome_message
    puts "Welcome to tic tac toe"
    puts " "
  end
  
  def display_goodbye_message
    puts "Thanks for playing tic tac toe!"
  end
  
  def clear_screen_and_display_board
    clear_screen
    board.draw
  end
  
  def human_moves
    square = nil
    puts "Choose a square (#{board.unmarked_keys.join(', ')}): "
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    
    board[square] = human.marker
  end
  
  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end
  
  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end
  
  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_result
    board.draw
    
    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end
  
  def play_again?
    answer = nil
    loop do 
      puts "Would you like to play again? (y/n)"
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
      @current_marker = FIRST_TO_MOVE
      clear_screen
      puts "Lets play again!"
      puts ""
  end
end

game = TTTGame.new
game.play