require_relative "../modules/options.rb"
require "./carriages/passenger_carriage.rb"
require "./carriages/cargo_carriage.rb"
require_relative "../modules/validation.rb"

class CarriageController
  include Options
  include Validation

  def initialize(carriages)
    @carriages = carriages
    carriage_controller
  end

  private

  def carriage_controller
    loop do
      show_options("Choose an action:", ["Create a carriage", "Show the list of carriages"])
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when "1"
        create_carriage_action
      when "2"
        carriages_list_action
      else
        print_wrong_option
      end
    end
  end

  def create_carriage_action
    loop do
      puts "============================="
      puts "Enter the name of a carriage:"
      puts "============================="
      name = ask_user
      break if EXIT_PROGRAM.include?(name)

      show_options("Enter the type of a carriage", ["Passenger", "Cargo"])
      type = ask_user

      case type
      when "1"
        @carriages << PassengerCarriage.new(name, "passenger")
      when "2"
        @carriages << CargoCarriage.new(name, "cargo")
      else
        print_wrong_option
        next
      end

      puts "================================"
      puts "A new carriage has been created!"
      puts "================================"
      break
    end
  end

  def carriages_list_action
    if (@carriages.size.zero?)
      show_no_subject("carriages")
      return
    end

    loop do
      puts "=========================="
      puts "List of carriages:"
      @carriages.each_with_index { |carriage, index| puts "Carriage #{index + 1} : #{carriage.name} - #{carriage.type} " }
      puts "=========================="

      puts "Which one do you want to choose?"
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer.to_i > @carriages.size)
        print_wrong_option
        next
      end

      carriage = @carriages[user_answer - 1]

      carriage_action(carriage)
    end
  end

  def carriage_action(carriage)
    loop do
      show_options("What do you want to do?", ["Show a manufacturer", "Set a manufacturer"])
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when "1"
        carriage.get_manufacturer
        next
      when "2"
        add_carriage_manufacturer(carriage)
        next
      else
        print_wrong_option
        next
      end
    end
  end

  def add_carriage_manufacturer(carriage)
    puts "================================="
    puts "Enter the name of a manufacturer:"
    puts "=================================="
    manufacturer = ask_user
    carriage.set_manufacturer(manufacturer)
    puts "===================================================================================="
    puts "Manufacturer - #{manufacturer} - has been updated for the carriage #{carriage.name}!"
    puts "===================================================================================="
  end
end
