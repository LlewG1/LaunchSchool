class Score
  attr_accessor :record, :game, :history

  def initialize 
    @record = {human: 0, computer: 0, ties: 0}
    @game = 0
    @history = {}
  end

  def update_game_number
    self.game += 1   
  end

  def update_score(winner)
    case winner 
    when 'human'
      self.record[:human] += 1
    when 'computer'
      self.record[:computer] += 1
    else 
      self.record[:ties] += 1 
    end
  end

  def move_history(human, computer) 
    self.history.store(self.game, [human.to_s, computer.to_s])
  end

end

class Move
  attr_reader :beats, :value, :loses
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock'].freeze

  def initialize(value)
    @move = nil
  end

  def move_wins?(other_move)
    beats.include?(other_move.to_s)
  end

  def to_s
    @value
  end

  def beat_move(human)
    loses.include?(human.move)
    return loses
  end

  def reduce_loss_against(human)
    beats.include?(human.move)
    return beats
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
    @beats = ['scissors', 'lizard']
    @loses = ['paper', 'spock']
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @beats = ['rock', 'spock']
    @loses = ['scissors', 'lizard']
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @beats = ['paper', 'lizard']
    @loses = ['rock', 'spock']
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @beats = ['paper', 'spock']
    @loses = ['scissors', 'rock']
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @beats = ['rock', 'scissors']
    @loses = ['lizard', 'paper']
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
    self.name = choice.downcase.capitalize
  end

  def choose
    choice = nil

    loop do
      puts "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp 
      break if Move::VALUES.include? choice.downcase
      puts "Sorry, invalid choice."
    end
    self.move = assign_class(choice.downcase)
  end
end

class R2D2 < Player 
  attr_reader :name

  def initialize 
    @name = 'R2D2'
  end

  def choose(score, human)
    self.move = assign_class('rock')
  end
end

class Hal < Player
  attr_reader :name, :move_bias 

  def initialize 
    @name = 'Hal'
    @move_bias = {'rock' => 20, 
                  'paper' => 20, 
                  'scissors' => 20, 
                  'lizard' => 20, 
                  'spock' => 20
                  }
  end

  def choose(score, human) 
    self.move = assign_class(sample_move_bias)
    update_move_bias(score, human)
  end

  def sample_move_bias 
    chances = []
    self.move_bias.each do |move,chance|
      chance.times do chances << move end
    end
    chances.sample
  end

  def update_move_bias(score, human)
    self.move_bias[human.move.beat_move(human).first] += 5
    self.move_bias[human.move.beat_move(human).last] += 5
    if self.move_bias[human.move.reduce_loss_against(human).first] > 0 
      self.move_bias[human.move.reduce_loss_against(human).first] -= 5 
    end
    if self.move_bias[human.move.reduce_loss_against(human).last] > 0
      self.move_bias[human.move.reduce_loss_against(human).last] -= 5 
    end
  end
end

class Chappie < Player 
  attr_reader :name

  def initialize 
    @name = 'Chappie'
  end

  def choose(score, human)
    self.move = assign_class(Move::VALUES.sample)
  end
end

class Sonny < Player
  attr_reader :name

  def initialize 
    @name = 'Sonny'
  end

  def choose(score, human)  
    self.move = assign_class(['rock','paper','scissors'].sample)
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
      puts "-" * (34 + human.name.length + computer.name.length)
      print "  Game #   |  #{human.name}" + " " * (13 - human.name.length)
      puts "|   #{computer.name}" + " " * (13 - computer.name.length)
      puts "-" * (34 + human.name.length + computer.name.length)  
      score.history.each do |game , results|
        print "    #{game}" + " " * (10 - game.to_s.length) + "#{results.first}"
        puts " " * (17 - results.first.length) + "#{results.last}  "
      end
      puts " "
    end
  end

  def display_game
    puts "    Ready? Game # #{score.game}"
    puts " "
  end

  def display_moves
    puts " "
    puts "#{human.name} chose:     #{computer.name} chose:"
    print "  #{human.move}" + " " * (16 - human.move.to_s.length)
    puts "#{computer.move}"
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
    print "The score is: #{human.name} with #{score.record[:human]} wins, "
    print "#{computer.name} with #{score.record[:computer]} wins, and"
    puts " #{score.record[:ties]} ties."
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

    return true if answer == 'y'
    return false if answer == 'n'
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
