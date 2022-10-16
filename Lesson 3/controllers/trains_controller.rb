require_relative "../modules/options"
require_relative "../trains/cargo_train"
require_relative "../trains/passenger_train"
require_relative "../trains/train"
require_relative "../modules/validation"

class TrainController
  include Options
  include Validation

  def initialize(trains, routes, carriages)
    @trains = trains
    @routes = routes
    @carriages = carriages
    train_controller
  end

  private

  def train_controller
    loop do
      show_options("Choose an action",
                   ["Create a train", "Update a train", "Move a train", "Find by number", "Amount of trains",
                    "Show train's carriages", "Validate a train"])
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when "1"
        create_train_action
      when "2"
        update_train_action
      when "3"
        move_train_action
      when "4"
        find_train_action
      when "5"
        trains_amount_action
      when "6"
        train_carriages_action
      when "7"
        train_validation_action
      else
        puts "Undefined"
        break if EXIT_PROGRAM.include?(user_answer)
      end
    end
  end

  def train_validation_action
    if @trains.size.zero?
      show_no_subject("trains")
      return
    end

    loop do
      puts "=========================="
      puts "What train do you want to see?"
      @trains.each_with_index { |train, index| puts "#{index + 1} - Train: #{train.number} type: #{train.type}" }
      puts "=========================="
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i
      if !user_answer.positive? || user_answer > @trains.size
        break if EXIT_PROGRAM.include?(user_answer)
        print_wrong_option
        next
      end

      target_train = @trains[user_answer - 1]

      is_valid = target_train.valid?

      if (target_train.valid?)
        "Train #{target_train.number} is valid"
      else
        "Train #{target_train.number} is invalid"
      end
      break
    end
  end

  def train_carriages_action
    if @trains.size.zero?
      show_no_subject("trains")
      return
    end
    loop do
      puts "=========================="
      puts "What train do you want to see?"
      @trains.each_with_index { |train, index| puts "#{index + 1} - Train: #{train.number} type: #{train.type}" }
      puts "=========================="
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i
      if !user_answer.positive? || user_answer > @trains.size
        break if EXIT_PROGRAM.include?(user_answer)

        print_wrong_option
        next
      end

      target_train = @trains[user_answer - 1]

      if target_train.carriages.size.zero?
        show_no_subject("carriages found")
        next
      end

      target_train.iterate_through_carriages do |carriage|
        puts "Carriage: #{carriage.name}, capacity: #{carriage.volume}, avaliable seats #{carriage.free_volume}"
      end

      break
    end
  end

  def trains_amount_action
    show_options("What is the type of the train?", %w[Passenger Cargo])
    type = ask_user
    return if EXIT_PROGRAM.include?(type)

    case type
    when "1"
      PassengerTrain.instances
    when "2"
      CargoTrain.instances
    else
      print_wrong_option
    end
  end

  def find_train_action
    puts "============================"
    puts "Enter a number of the train:"
    puts "============================"

    user_answer = ask_user
    target_train = Train.find(user_answer)
    if target_train.nil?
      puts "Train is not found"
    else
      puts "Train: #{target_train}"
      target_train
    end
  end

  def create_train_action
    loop do
      puts "============================"
      puts "Enter the number of a train:"
      puts "============================"
      number = ask_user
      break if EXIT_PROGRAM.include?(number)

      begin
        raise "Wrong number format" unless number =~ Train::TRAIN_NUMBER
      rescue StandardError
        puts "Wrong number, try again!"
        next
      end

      show_options("What is the type of the train?", %w[Passenger Cargo])
      type = ask_user
      return if EXIT_PROGRAM.include?(type)

      case type
      when "1"
        @trains << PassengerTrain.new(number, "passenger")
        break
      when "2"
        @trains << CargoTrain.new(number, "cargo")
        return
      else
        print_wrong_option
        next
      end
    end
  end

  def move_train_action
    if @trains.size.zero?
      show_no_subject("train to move")
      return
    end

    loop do
      puts "=========================="
      puts "What train do you want to move?"
      @trains.each_with_index { |train, index| puts "#{index + 1} - Train: #{train.number} type: #{train.type}" }
      puts "=========================="
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i
      if !user_answer.positive? || user_answer > @trains.size
        break if EXIT_PROGRAM.include?(user_answer)

        print_wrong_option
        next
      end

      train = @trains[user_answer - 1]
      move_train(train)
      break
    end
  end

  def move_train(train)
    if train.route.size.zero?
      show_no_subject("no route")
      return
    end
    loop do
      show_options("Choose the action", ["Move forward", "Move back"])

      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when "1"
        train.to_next_station
      when "2"
        train.to_previous_station
      else
        print_wrong_option
      end
    end
  end

  def update_train_action
    if @trains.size.zero?
      show_no_subject("train to update")
      return
    end

    puts "==================================="
    puts "What train do you want to update?"
    @trains.each_with_index do |train, index|
      puts "#{index + 1} - Train #{index + 1}: #{train.number}, Type: #{train.type}"
    end
    puts "==================================="

    loop do
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i
      if !user_answer.positive? || user_answer > @trains.size
        break if EXIT_PROGRAM.include?(user_answer)

        print_wrong_option
        next
      end

      train = @trains[user_answer - 1]
      update_train(train)
      break
    end
  end

  def update_train(train)
    loop do
      show_options("Choose the action",
                   ["Add a carriage", "Remove a carriage", "Set a route", "Set speed", "Stop the train", "Set a manufacturer",
                    "Show manufacturer"])

      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when "1"
        add_carriage_to_train(train)
      when "2"
        remove_carriage_from_train(train)
      when "3"
        add_route_to_train(train)
      when "4"
        puts "Enter a speed:"
        speed = ask_user.to_i
        train.speed = speed
      when "5"
        train.stop
      when "6"
        add_train_manufacturer(train)
      when "7"
        train.manufacturer
      else
        print_wrong_option
      end
    end
  end

  def add_train_manufacturer(train)
    puts "==================================="
    puts "Enter the name of a manufacturer:"
    puts "==================================="
    manufacturer = ask_user
    train.add_manufacturer(manufacturer)
    puts "============================================================================="
    puts "Manufacturer: #{manufacturer} for the train #{train.number} has been updated!"
    puts "============================================================================="
  end

  def add_carriage_to_train(train)
    filtered_carriages = @carriages.select do |carriage|
      !train.carriages.include?(carriage) && !check_carriage_in_trains(carriage)
    end

    if filtered_carriages.size.zero?
      show_no_subject("carriages")
      return
    end

    loop do
      puts "==================================="
      puts "List of carriages:"
      filtered_carriages.each_with_index do |carriage, index|
        puts "#{index + 1} - Carriage #{index + 1}: #{carriage.name}, Type: #{carriage.type}"
      end
      puts "==================================="
      puts "Which one would you like to add?"
      puts "==================================="
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i
      if !user_answer.positive? || user_answer > filtered_carriages.size
        print_wrong_option
        next
      end

      carriage = filtered_carriages[user_answer - 1]
      prev_train_amount = train.carriages.size
      train.add_carriage(carriage)
      if train.carriages.size > prev_train_amount
        puts "#########################################################################"
        puts "The carriage #{carriage.name} has been added to the train #{train.number}"
        puts "#########################################################################"
      end
      return
    end
  end

  def check_carriage_in_trains(carriage)
    @trains.any? { |train| train.carriages.include?(carriage) }
  end

  def remove_carriage_from_train(train)
    if train.carriages.size.zero?
      show_no_subject("carriages")
    else
      prev_train_amount = train.carriages.size
      train.remove_carriage
      if train.carriages.size < prev_train_amount
        puts "#############################"
        puts "The carriage has been deleted"
        puts "#############################"
      end
    end
  end

  def add_route_to_train(train)
    if @routes.size.zero?
      show_no_subject("routes")
      return
    end

    loop do
      puts "==================================="
      puts "List of routes:"
      @routes.each_with_index { |routes, index| puts "#{index + 1} - Route #{index + 1}: #{routes.name}" }
      puts "==================================="
      puts "Which one would you like to add?"
      puts "==================================="
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i
      if !user_answer.positive? || user_answer > @routes.size
        print_wrong_option
        next
      end

      route = @routes[user_answer - 1]
      train.add_route(route)
      puts "#############################################"
      puts "A new route -  #{route.name} - has been set"
      puts "#############################################"
      break
    end
  end
end
