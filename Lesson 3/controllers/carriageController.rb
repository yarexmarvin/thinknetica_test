require "./carriages/passengerCarriage.rb"
require "./carriages/cargoCarriage.rb"

class CarriageController
  EXIT_PROGRAM = "back"

  def initialize(carriages)
    @carriages = carriages
    carriage_controller
  end

  private
  def carriage_controller
    loop do
      puts "Choose an action:"
      puts "1 - create a carriage"
      puts "2 - show the list of carriages"
      puts "Enter 'back' to move back"

      user_answer = gets.chomp
      break if user_answer == EXIT_PROGRAM

      case user_answer
      when "1"
        create_carriage_action
      when "2"
        carriages_list_action
      else
        puts "Undefined"
      end
    end
  end

  def create_carriage_action
    puts "=========================="
    puts "Enter the name of a carriage:"
    puts "=========================="
    name = gets.chomp
    puts "=========================="
    puts "Enter the type of a carriage (passenger/cargo)"
    puts "1 - Passenger"
    puts "2 - Cargo"
    puts "=========================="
    type = gets.chomp

    case type
    when "1"
      return @carriages << PassengerCarriage.new(name, "passenger")
    when "2"
      return @carriages << CargoCarriage.new(name, "cargo")
    else
      puts "=========================="
      puts "Wrong type, try again"
      puts "=========================="
      return
    end
  end

  def carriages_list_action
    if (@carriages.size.zero?)
      puts "=========================="
      puts "There are no carriages"
      puts "=========================="
      return
    end
    puts "=========================="
    puts "List of carriages:"
    @carriages.each_with_index { |carriage, index| puts "Carriage #{index + 1} : #{carriage.name} - #{carriage.type} " }
    puts "=========================="
    return
  end

end
