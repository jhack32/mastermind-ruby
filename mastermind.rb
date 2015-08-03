#Mastermind game

module ColorModule #The COLORS constant is inside this module.
  COLORS = ["red", "green", "yellow", "blue", "orange", "purple"]
end


class Mastermind
  include ColorModule
  attr_accessor :hint

  def initialize
    @hint = []
    @human = Human.new
    @computer = Computer.new
  end #End of initialize

  def game
    @human.humanname
    choose_mode
    if @choose_mode_input == "code breaker"
      puts "Hello #{@human.name}."
      puts "You have chosen to be the CODE BREAKER!"
      code_breaker
    elsif @choose_mode_input == "code maker"
      puts "Hello #{@human.name}."
      puts "You have chosen to be the CODE MAKER!"
      code_maker
    else
      puts "Hello #{@human.name}."
      puts "Please enter a valid input. (code breaker/code maker)"
    end #End of if/elsif/else statements
  end #End of game

    def choose_mode
      puts "To get started #{@human.name}, please enter the mode you would like to play in"
      puts "Code breaker or Code maker"
      @choose_mode_input = gets.chomp.downcase
    end #End of choose_mode

    def code_breaker
      puts "Okay, code breaker. The computer will generate a random code that you will have to guess."
      i = 1
      @computer.create_code
      if i < 12
        puts "The colors you can choose from are "
        puts  COLORS.to_s
        puts "Please enter your 4-letter color guess: "
        puts "Please press enter after every color"
        @human.guess
        results
      end
    end #End of code_breaker

    def code_maker
      puts "Your choices are: " + COLORS.to_s
      puts "Enter the four combination colors you want as an answer."
      puts "You will have 12 turns to guess! Good luck!"
      puts "Press enter after every color"
      puts ""
      4.times { @human.code << human_code = gets.chomp.downcase }
      # the code above gets input(4 times) from the user to create an answer for
      # the computer to guess. then pushes it to the code array.
      puts "The answer you have created is: #{@human.code}"
      @computer.guess #The computer will make guesses
    end #End of code_maker


end #End of Mastermind class

class Human
  include ColorModule
  attr_accessor :name, :code
  def initialize
    @code = [] #This is the answer the human makes
    @guesses = []
  end #End of initialize

  def humanname
    puts "Hello! Welcome to the command-line ruby Mastermind game!"
    puts "Please enter your name"
    @name = gets.chomp
  end

  def guess
    i = 1
    while i < 12
      4.times { @guesses << humanguesses = gets.chomp.downcase }
      puts "#{@answer}"
      puts "#{@guesses}"
      if @guesses != @answer
        guess_again
        i += 1
        puts "Turn #: #{i}"
        puts ""
      elsif @guesses == @answer
        puts "You WIN! You guessed it correctly!"
        puts "The answer: #{@answer} is the same as yours #{@guesses}"
      end
    end
  end #End of guess
  def guess_again
    puts "Wrong! Guess again!"
    puts "Your last guess was: #{@guesses}" #Displays the previous guess
    @guesses = Array.new # Resets the array every time guessed wrong
  end

end #End of Human class

class Computer
  include ColorModule
  attr_accessor :answer
  def initialize
    @guess = []
    @human = Human.new
  end

  def create_code
    @answer = COLORS.sample(4)
    puts "#{@answer}"
  end

  def make_guess
    @guess = COLORS.sample(4)
  end

  def guess
    puts "The computer will now guess..."
    i = 0
   while i < 12
     make_guess
     i += 1
     if @guess == @human.code
       puts "The computer got it right at #{i} turn! You LOSE!"
       puts "The answer is #{@guess}"
     else
       make_guess
       puts "The computer is making another guess. Turn #: #{i}"
       sleep 0.5
       if i == 12
         puts "YOU WIN!!!! The computer did not guess correctly in 12 turns!"
       end
     end
   end
  end
end #End of Computer class



start = Mastermind.new
start.game
