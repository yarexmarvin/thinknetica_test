require_relative "../modules/options.rb"
require_relative "../trains/cargo_train.rb"
require_relative "../trains/passenger_train.rb"
require_relative "../modules/validation.rb"

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
      show_options("Choose an action", ["Create a train", "Update a train", "Move a train", "Find by number", "Amount of trains"])
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
      else
        puts "Undefined"
        break if EXIT_PROGRAM.include?(user_answer)
      end
    end
  end

  def trains_amount_action
    show_options("What is the type of the train?", ["Passenger", "Cargo"])
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
    if (target_train.nil?)
      puts "Train is not found"
    else
      puts "Train: #{target_train}"
    end
  end

  def create_train_action
    loop do
      puts "============================"
      puts "Enter the number of a train:"
      puts "============================"
      number = ask_user
      break if EXIT_PROGRAM.include?(number)

      validNumber = valid("train", "number", number)

      unless (validNumber)
        next
      end

      show_options("What is the type of the train?", ["Passenger", "Cargo"])
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
    if (@trains.size.zero?)
      show_no_subject("train to move")
      return
    end

    loop do
      puts "=========================="
      puts "What train do you want to move?"
      @trains.each_with_index { |train, index| puts "Train #{index + 1}: #{train.number} type: #{train.type}" }
      puts "=========================="
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @trains.size)
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
    if (train.route.size.zero?)
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
    if (@trains.size.zero?)
      show_no_subject("train to update")
      return
    end

    puts "==================================="
    puts "What train do you want to update?"
    @trains.each_with_index { |train, index| puts "#{index + 1} - Train #{index + 1}: #{train.number}, Type: #{train.type}" }
    puts "==================================="

    loop do
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @trains.size)
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
      show_options("Choose the action", ["Add a carriage", "Remove a carriage", "Set a route", "Set speed", "Stop the train", "Set a manufacturer", "Show manufacturer"])

      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when "1"
        add_carriage_to_train(train)
      when "2"
        train.remove_carriage
      when "3"
        set_route_to_train(train)
      when "4"
        puts "Enter a speed:"
        speed = ask_user.to_i
        train.speed = speed
      when "5"
        train.stop
      when "6"
        add_train_manufacturer(train)
      when "7"
        train.get_manufacturer
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
    train.set_manufacturer(manufacturer)
    puts "============================================================================="
    puts "Manufacturer: #{manufacturer} for the train #{train.number} has been updated!"
    puts "============================================================================="
  end

  def add_carriage_to_train(train)
    if (@carriages.size.zero?)
      show_no_subject("carriages")
      return
    end

    loop do
      puts "==================================="
      puts "List of carriages:"
      @carriages.each_with_index { |carriage, index| puts "#{index + 1} - Carriage #{index + 1}: #{carriage.name}, Type: #{carriage.type}" }
      puts "==================================="
      puts "Which one would you like to add?"
      puts "==================================="
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @carriages.size)
        print_wrong_option
        next
      end

      carriage = @carriages[user_answer - 1]
      train.add_carriage(carriage)
      puts "#########################################################################"
      puts "The carriage #{carriage.name} has been added to the train #{train.number}"
      puts "#########################################################################"
      return
    end
  end

  def remove_carriage_from_train(train)
    if (train.carriages.size.zero?)
      show_no_subject("carriages")
      return
    else
      train.remove_carriage
      puts "#############################"
      puts "The carriage has been deleted"
      puts "#############################"
      return
    end
  end

  def set_route_to_train(train)
    if (@routes.size.zero?)
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
      if (!user_answer.positive? || user_answer > @routes.size)
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
