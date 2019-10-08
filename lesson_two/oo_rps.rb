
class RPSGame
  attr_accessor :human, :computer

  def initialize
    system 'clear'
    @human = Human.new
    @computer = Computer.new
  end

  def play
    system 'clear'
    display_welcome_message
    loop do
      loop do
        core_game
        break if winner?
      end
      display_winner
      display_move_history
      break unless play_again?
      system 'clear'
    end
    display_goodbye_message
  end

  def core_game
    human.choose
    computer.choose
    record_moves
    system 'clear'
    display_moves
    keep_score
    display_round_winner
    display_score
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
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
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
    elsif human.move < computer.move
      puts "#{computer.name} won the round!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "#{human.name} has won #{human.score} rounds!"
    puts "#{computer.name} has won #{computer.score} rounds!"
  end

  def winner?
    computer.score >= 10 || human.score >= 10
  end

  def keep_score
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
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
end

class Player
  attr_accessor :name, :score, :move_history
  attr_reader :move

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
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
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
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    choice = Move::VALUES.sample
    self.move = choice
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

  def <(other_move)
    other_move.scissors? || other_move.rock?
  end

  def to_s
    'lizard'
  end
end

class Rock < Move
  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end

  def <(other_move)
    other_move.paper? || other_move.spock?
  end

  def to_s
    'rock'
  end
end

class Paper < Move
  def >(other_move)
    other_move.rock? || other_move.spock?
  end

  def <(other_move)
    other_move.scissors? || other_move.lizard?
  end

  def to_s
    'paper'
  end
end

class Scissors < Move
  def >(other_move)
    other_move.lizard? || other_move.paper?
  end

  def <(other_move)
    other_move.rock? || other_move.rock?
  end

  def to_s
    'scissors'
  end
end

class Spock < Move
  def >(other_move)
    other_move.rock? || other_move.scissors?
  end

  def <(other_move)
    other_move.lizard? || other_move.paper?
  end

  def to_s
    'spock'
  end
end

RPSGame.new.play
