class SecretCode

  def initialize()
    @correct_code = []
    build_code()
  end

  def build_code()
    4.times do
      color = rand(1..6)
      case color
      when 1
        @correct_code.push("R")
      when 2
        @correct_code.push("O")
      when 3
        @correct_code.push("Y")
      when 4
        @correct_code.push("G")
      when 5
        @correct_code.push("B")
      when 6
        @correct_code.push("P") 
      end
    end
  end

  def show_code()
    puts @correct_code
  end
end

my_code = SecretCode.new()
my_code.show_code()