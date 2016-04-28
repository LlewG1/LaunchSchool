class Score
  attr_accessor :record, :game, :history

  def initialize
    @record = { human: 0, computer: 0, ties: 0 }
    @game = 0
    @history = {}
  end

  def update_game_number
    self.game += 1
  end

  def update_score(winner)
    case winner
    when 'human'
      record[:human] += 1
    when 'computer'
      record[:computer] += 1
    else
      record[:ties] += 1
    end
  end

  def move_history(human, computer)
    history.store(self.game, [human.to_s, computer.to_s])
  end
end

class Move
  attr_reader :beats, :value, :loses
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock'].freeze

  def initialize
    @move = nil
  end

  def move_wins?(other_move)
    beats.include?(other_move.to_s)
  end

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
    @beats = %w(scissors lizard)
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @beats = %w(rock spock)
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @beats = %w(paper lizard)
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @beats = %w(paper spock)
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @beats = %w(rock scissors)
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end

  def assign_class(choice)
    case choice
    when 'rock' then Rock.new
    when 'paper' then Paper.new
    when 'scissors' then Scissors.new
    when 'lizard' then Lizard.new
    when 'spock' then Spock.new
    end
  end
end

class Human < Player
  def set_name
    choice = ""
    loop do
      puts "Whats your name?"
      choice = gets.chomp
      break unless choice.empty?
      puts "Sorry, must enter a valid name."
    end
    self.name = choice.capitalize
  end

  def choose
    choice = nil

    loop do
      puts "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = assign_class(choice)
  end
end

class R2D2 < Player
  def initialize
    @name = 'R2D2'
  end

  def choose(*)
    self.move = assign_class('rock')
  end
end

class Hal < Player
  def initialize
    @name = 'Hal'
    @move_bias = { 'rock' => 5,
                   'paper' => 5,
                   'scissors' => 5,
                   'lizard' => 5,
                   'spock' => 5
                   }
  end

  def choose(score, human)
    self.move = assign_class(determine_move)
    update_move_bias(score, human)
  end

  def determine_move
    possible_moves = []
    @move_bias.each do |move, chance|
      chance.times { possible_moves << move }
    end
    possible_moves.sample
  end

  def update_move_bias(*, human)
    beat_opponent_moves = Move::VALUES - human.move.beats - human.move.value.split

    @move_bias.each do |move, value|
      if beat_opponent_moves.include? move
        @move_bias[move] += 1
      else
        @move_bias[move] -= 1 unless value <= 0
      end
    end
  end
end

class Chappie < Player
  def initialize
    @name = 'Chappie'
  end

  def choose(*)
    self.move = assign_class(Move::VALUES.sample)
  end
end

class Sonny < Player
  def initialize
    @name = 'Sonny'
  end

  def choose(*)
    self.move = assign_class(%w(rock paper scissors).sample)
  end
end

# ----------------
#   GAME CLASS
# ----------------

class RPSGame
  attr_accessor :human, :computer, :score

  def initialize
    @human = Human.new
    @score = Score.new
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def display_welcome_message
    puts " "
    puts "-" * 50
    puts "Welcome #{human.name} to Rock, Paper, Scissors, Lizard, Spock"
    puts "          Best of 5 take the overall win!"
    puts "                   Goodluck!"
    puts " "
  end

  def choose_opponent
    choice = ""
    loop do
      puts <<~DOC
      Please choose an opponent from the list below
      1 - R2D2     "R2D2 loves rocks"
      2 - Hal      "very smart, Hal will attempt to win with logic applied"
      3 - Chappie  "still innocent, Chappie will guess one of the five choices"
      4 - Sonny    "only knows the three laws"

      Enter 1, 2, 3 or 4

      DOC
      choice = gets.chomp.to_i
      break if [1, 2, 3, 4].include? choice
      puts "Not a valid choice"
      puts " "
    end

    case choice
    when 1 then @computer = R2D2.new
    when 2 then @computer = Hal.new
    when 3 then @computer = Chappie.new
    when 4 then @computer = Sonny.new
    end
  end

  def display_history
    if score.game > 0
      history_header
      history_results
    end
  end

  def history_header
    hum_chars = human.name.length
    opp_chars = computer.name.length
    combined_chars = human.name.length + computer.name.length

    puts "-" * (34 + combined_chars)
    puts "  Game #   |  #{human.name}  #{' ' * (13 - hum_chars)}"\
         "|   #{computer.name}" + " " * (13 - opp_chars)
    puts "-" * (34 + combined_chars)
  end

  def history_results
    score.history.each do |game, results|
      puts "    #{game} #{' ' * (10 - game.to_s.length)} #{results.first}" +
           " " * (17 - results.first.length) + results.last
    end
    puts " "
  end

  def display_game
    puts "    Ready? Game # #{score.game}"
    puts " "
  end

  def display_moves
    puts " "
    puts "#{human.name} chose:     #{computer.name} chose:"
    puts "  #{human.move} #{' ' * (16 - human.move.to_s.length)}"\
         "#{computer.move}"
  end

  def determine_winner
    if human.move.move_wins?(computer.move)
      return 'human'
    elsif computer.move.move_wins?(human.move)
      return 'computer'
    end
  end

  def display_winner
    puts " "
    case determine_winner
    when 'human'
      puts "         #{human.name} won!"
    when 'computer'
      puts "         #{computer.name} won!"
    else
      puts "         It's a tie!"
    end
  end

  def display_score
    puts " "
    puts "The score is: #{human.name} with #{score.record[:human]} wins, "\
         "#{computer.name} with #{score.record[:computer]} wins, and"\
         " #{score.record[:ties]} ties."
  end

  def overall_win?
    if score.record[:human] == 5
      display_overall_win(human.name)
      return true
    elsif score.record[:computer] == 5
      display_overall_win(computer.name)
      return true
    end
  end

  def display_overall_win(player)
    puts " "
    puts "#{player} won best of 5! Congradulations!"
  end

  def play_again?
    answer = nil
    loop do
      puts " "
      puts "Ready to continue #{human.name}? Enter 'y' to go on or 'n' to quit:"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be 'y' or 'n'"
    end

    answer == 'y'
  end

  def display_goodbye_message
    puts " "
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock!"
  end

  def play
    clear_screen
    display_welcome_message
    sleep 1.5
    choose_opponent
    clear_screen
    sleep 0.5
    loop do
      display_history
      score.update_game_number
      display_game
      human.choose
      computer.choose(score, human)
      display_moves
      sleep 0.8
      display_winner
      sleep 0.8
      score.update_score(determine_winner)
      score.move_history(human.move, computer.move)
      display_score
      break if overall_win?
      break unless play_again?
      clear_screen
    end
    display_goodbye_message
  end
end

RPSGame.new.play
