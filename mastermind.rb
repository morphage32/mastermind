class SecretCode

  def initialize()
    @correct_colors = []
    build_code()
  end

  def build_code()
    i = 0
    4.times do
      color = rand(1..6)
      case color
      when 1
        @correct_colors.push("R")
      when 2
        @correct_colors.push("O")
      when 3
        @correct_colors.push("Y")
      when 4
        @correct_colors.push("G")
      when 5
        @correct_colors.push("B")
      when 6
        @correct_colors.push("P") 
      end
    end
  end

  def check_guess(guess)
    guess_colors = guess.split("")
    close_items = @correct_colors.join

    exact_guesses = 0
    close_guesses = 0

    # check which colors are in exactly the right spot
    i = 0
    4.times do
      if @correct_colors[i] == guess_colors[i]
        exact_guesses += 1
      end
      i += 1
    end

    # end the game if guess is exactly correct
    if exact_guesses == 4
      return true
    end

    # check for ANY matching colors in the correct code,
    # matches are counted and removed so that they are not over-counted
    # when duplicates are present. This count includes exact matches,
    # so the final count must subtract them.
    guess_colors.each do |guess|
      if close_items.include?(guess)
        close_items[guess] = ""
        close_guesses += 1
      end
    end

    close_guesses -= exact_guesses

    puts "Results: #{exact_guesses} correct. #{close_guesses} close."
    return false
  end

  def reveal_code()
    return @correct_colors.join
  end
end

class User

  def choose_role()
    player_choice = '0'

    until player_choice == '1' || player_choice == '2'
      player_choice = gets.chomp
      unless player_choice == '1' || player_choice == '2'
        puts "Sorry, please enter only the number '1' or '2' to play!"
      end
    end

    return player_choice.to_i
  end

  def make_guess()

    valid_guess = false

    until valid_guess do
      player_guess = gets.chomp
      player_guess = player_guess.upcase

      if player_guess.length != 4
        puts "Sorry, your code must be 4 characters long."
      elsif player_guess.count("ROYGBP") != 4
        puts "Sorry, your code must only contain the letters 'R', 'O', 'Y', 'G', 'B', or 'P'."
      else
        valid_guess = true
      end
    end
    player_guess
  end

end

def menu()
  current_user = User.new()
  role = 0

  puts "-=MASTERMIND=- \nEnter '1' to be the Code-Breaker or '2' to be the Code-Maker:"
  role = current_user.choose_role

  if role == 1
    codebreaker_game(current_user)
  else
    codemaker_game(current_user)
  end

end

def codebreaker_game(player)

  game_code = SecretCode.new()
  solved = false

  puts "Please enter a 4-letter code using only the letters 'R', 'O', 'Y', 'G', 'B', or 'P'."
  total_guesses = 1

  until total_guesses > 12 || solved
    puts "Guess ##{total_guesses}:"
    solved = game_code.check_guess(player.make_guess)
    total_guesses += 1
  end

  if solved
    puts "CONGRATULATIONS! You cracked the code!"
  else
    puts "GAME OVER! The correct code was #{game_code.reveal_code}"
  end

end

def codemaker_game(player)

end

menu()