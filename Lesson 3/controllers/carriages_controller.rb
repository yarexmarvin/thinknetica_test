require_relative "../modules/options_module.rb"
require "./carriages/passenger_carriage.rb"
require "./carriages/cargo_carriage.rb"

class CarriageController
  include Options

  def initialize(carriages)
    @carriages = carriages
    carriage_controller
  end

  private

  def carriage_controller
    loop do
      show_options("Choose an action:", ["Create a carriage", "Show the list of carriages"])
      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

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
    puts "=========================="
    puts "Enter the name of a carriage:"
    puts "=========================="
    name = ask_user
    show_options("Enter the type of a carriage", ["Passenger", "Cargo"])
    type = ask_user

    case type
    when "1"
      @carriages << PassengerCarriage.new(name, "passenger")
    when "2"
      @carriages << CargoCarriage.new(name, "cargo")
    else
      print_wrong_option
      return
    end

    puts "================================"
    puts "A new carriage has been create!"
    puts "================================"
    return
  end

  def carriages_list_action
    if (@carriages.size.zero?)
      show_no_subject("carriages")
      return
    end
    puts "=========================="
    puts "List of carriages:"
    @carriages.each_with_index { |carriage, index| puts "Carriage #{index + 1} : #{carriage.name} - #{carriage.type} " }
    puts "=========================="
    return
  end
end
