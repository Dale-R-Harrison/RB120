
class RPSGame
  def initialize
    system 'clear'
    @human = Human.new
    opponent_select
  end

  def play
    system 'clear'
    display_welcome_message
    loop do
      core_game
      display_winner
      display_move_history
      break unless play_again?
      reset_game
      system 'clear'
    end
    display_goodbye_message
  end

  # seperated out code from main loop to reduce complexity of play method

  def core_game
    loop do
      human.choose
      computer.choose
      record_moves
      system 'clear'
      display_moves
      keep_score
      display_round_winner
      display_score
      break if winner?
    end
  end

  def reset_game
    human.score = 0
    computer.score = 0
    human.move_history = []
    computer.move_history = []
  end

  def play_again?
    answer = nil
    loop do
      puts ""
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def display_welcome_message
    puts "Hello #{human.name}. Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "Your opponent is #{computer.name}."
    puts "The first to 10 points wins the game!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_round_winner
    if human.move > computer.move
      puts "#{human.name} won the round!"
    elsif computer.move > human.move
      puts "#{computer.name} won the round!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "---------------"
    puts "#{human.name} has won #{human.score} rounds!"
    puts "#{computer.name} has won #{computer.score} rounds!"
    puts "---------------"
  end

  def winner?
    computer.score >= 10 || human.score >= 10
  end

  def keep_score
    if human.move > computer.move
      human.score += 1
    elsif computer.move > human.move
      computer.score += 1
    end
  end

  def display_winner
    if human.score >= 10
      puts "#{human.name} wins the game!"
    else
      puts "#{computer.name} wins the game!"
    end
  end

  def record_moves
    human.record_move
    computer.record_move
  end

  def display_move_history
    puts "#{human.name}'s moves: "
    puts "#{human.move_history.join(', ').capitalize}."
    puts " "
    puts "#{computer.name}'s moves: "
    puts "#{computer.move_history.join(', ').capitalize}."
  end

  def opponent_select
    n = Computer::NAMES.sample

    case n
    when 'Chappie'
      @computer = Chappie.new
    when 'R2D2'
      @computer = R2D2.new
    when 'Sonny'
      @computer = Sonny.new
    when 'Hal'
      @computer = Hal.new
    when 'Number 5'
      @computer = Number5.new
    end
  end

  private

  attr_reader :human, :computer
end

class Player
  attr_accessor :score, :move_history
  attr_reader :move, :name

  def initialize
    set_name
    @score = 0
    @move_history = []
  end

  def move=(choice)
    case choice
    when 'rock'
      @move = Rock.new
    when 'paper'
      @move = Paper.new
    when 'scissors'
      @move = Scissors.new
    when 'lizard'
      @move = Lizard.new
    when 'spock'
      @move = Spock.new
    end
  end

  def record_move
    move_history << move.to_s
  end

  protected

  attr_writer :name
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty? || n == ' '
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = choice
  end
end

class Computer < Player
  NAMES = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']

  def set_name
    self.name = NAMES.sample
  end

  def choose
    self.move = Move::VALUES.sample
  end
end

class Chappie < Computer
  def set_name
    @name = 'Chappie'
  end
end

class R2D2 < Computer
  def choose
    self.move = 'rock'
  end
end

class Hal < Computer
  def choose
    self.move = ['scissors', 'scissors', 'scissors', 'scissors',
                 'rock', 'lizard', 'spock'].sample
  end

  def set_name
    @name = 'Hal'
  end
end

class Number5 < Computer
  def choose
    self.move = ['paper', 'paper', 'spock', 'spock', 'lizard',
                 'scissors'].sample
  end

  def set_name
    @name = 'Number 5'
  end
end

class Sonny < Computer
  def choose
    self.move = ['rock', 'paper', 'scissors'].sample
  end

  def set_name
    @name = 'Sonny'
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def scissors?
    instance_of?(Scissors)
  end

  def rock?
    instance_of?(Rock)
  end

  def paper?
    instance_of?(Paper)
  end

  def spock?
    instance_of?(Spock)
  end

  def lizard?
    instance_of?(Lizard)
  end
end

class Lizard < Move
  def >(other_move)
    other_move.spock? || other_move.paper?
  end

  def to_s
    'lizard'
  end
end

class Rock < Move
  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end

  def to_s
    'rock'
  end
end

class Paper < Move
  def >(other_move)
    other_move.rock? || other_move.spock?
  end

  def to_s
    'paper'
  end
end

class Scissors < Move
  def >(other_move)
    other_move.lizard? || other_move.paper?
  end

  def to_s
    'scissors'
  end
end

class Spock < Move
  def >(other_move)
    other_move.rock? || other_move.scissors?
  end

  def to_s
    'spock'
  end
end

RPSGame.new.play
