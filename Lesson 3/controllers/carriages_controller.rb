require_relative '../modules/options'
require './carriages/passenger_carriage'
require './carriages/cargo_carriage'
require_relative '../modules/validation'

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
      show_options('Choose an action:', ['Create a carriage', 'Show the list of carriages'])
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when '1'
        create_carriage_action
      when '2'
        carriages_list_action
      else
        print_wrong_option
      end
    end
  end

  def create_carriage_action
    loop do
      puts '============================='
      puts 'Enter the name of a carriage:'
      puts '============================='
      name = ask_user
      break if EXIT_PROGRAM.include?(name)

      show_options('Enter the type of a carriage', %w[Passenger Cargo])
      type = ask_user
      break if EXIT_PROGRAM.include?(type)

      case type
      when '1'
        create_passenger_carriage(name)
      when '2'
        create_cargo_carriage(name)
      else
        print_wrong_option
        next
      end
      break
    end
  end

  def create_passenger_carriage(name)
    loop do
      puts 'How many seats in this carriage?'
      seats = ask_user

      if seats.to_i <= 0
        print_wrong_option
        next
      end

      @carriages << PassengerCarriage.new(name, 'passenger', seats.to_i)

      puts '================================'
      puts 'A new carriage has been created!'
      puts '================================'

      break
    end
  end

  def create_cargo_carriage(name)
    loop do
      puts 'What is the carriage capacity?'
      capacity = ask_user

      if capacity.to_i <= 0
        print_wrong_option
        next
      end

      @carriages << CargoCarriage.new(name, 'cargo', capacity.to_i)

      puts '================================'
      puts 'A new carriage has been created!'
      puts '================================'
      break
    end
  end

  def carriages_list_action
    if @carriages.size.zero?
      show_no_subject('carriages')
      return
    end

    loop do
      puts '=========================='
      puts 'List of carriages:'
      @carriages.each_with_index do |carriage, index|
        puts "Carriage #{index + 1} : #{carriage.name} - #{carriage.type} "
      end
      puts '=========================='

      puts 'Which one do you want to choose?'
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i
      if !user_answer.positive? || user_answer.to_i > @carriages.size
        print_wrong_option
        next
      end

      carriage = @carriages[user_answer - 1]

      carriage_action(carriage, carriage.type)
    end
  end

  def carriage_action(carriage, type)
    case type
    when 'passenger'
      passenger_carriage_actions(carriage)
    when 'cargo'
      cargo_carriage_actions(carriage)
    end
  end

  def passenger_carriage_actions(carriage)
    loop do
      show_options('What do you want to do?',
                   ['Show a manufacturer', 'Set a manufacturer', 'Show amount of seats', 'Show available seats',
                    'Take a seat'])
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when '1'
        carriage.get_manufacturer
      when '2'
        add_carriage_manufacturer(carriage)
      when '3'
        puts "Total amount of seats: #{carriage.volume}"
      when '4'
        puts "Available seats: #{carriage.free_volume}"
      when '5'
        carriage.fill_volume
      else
        print_wrong_option
      end
    end
  end

  def cargo_carriage_actions(carriage)
    loop do
      show_options('What do you want to do?',
                   ['Show a manufacturer', 'Set a manufacturer', 'Show a carriage capacity', 'Show available capacity',
                    'Fill the capacity'])
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when '1'
        carriage.get_manufacturer
      when '2'
        add_carriage_manufacturer(carriage)
      when '3'
        puts "Total amount of capacity: #{carriage.volume}"
      when '4'
        puts "Available capacity: #{carriage.free_volume}"
      when '5'
        fill_carriage_capacity(carriage)
      else
        print_wrong_option
      end
    end
  end

  def fill_carriage_capacity(carriage)
    loop do
      puts 'How much do you want to fill?'
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      if user_answer.to_i < 0
        print_wrong_option
        next
      end

      carriage.fill_volume(user_answer.to_i)
      break
    end
  end

  def add_carriage_manufacturer(carriage)
    puts '================================='
    puts 'Enter the name of a manufacturer:'
    puts '=================================='
    manufacturer = ask_user
    carriage.set_manufacturer(manufacturer)
    puts '===================================================================================='
    puts "Manufacturer - #{manufacturer} - has been updated for the carriage #{carriage.name}!"
    puts '===================================================================================='
  end
end
