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
  end

  def show_code()
    puts @correct_colors
  end
end

my_code = SecretCode.new()
my_code.show_code()
my_code.check_guess("YGBG")