require_relative "../modules/options_module.rb"
require_relative "../trains/cargo_train.rb"
require_relative "../trains/passenger_train.rb"

class TrainController
  include Options

  def initialize(trains, routes, carriages)
    @trains = trains
    @routes = routes
    @carriages = carriages
    train_controller
  end

  private
  def train_controller
    loop do
      show_options("Choose an action", ["Create a train", "Update a train", "Move a train"])

      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

      case user_answer
      when "1"
        create_train_action
      when "2"
        update_train_action
      when "3"
        move_train_action
      else
        puts "Undefined"
        break if user_answer == EXIT_PROGRAM
      end
    end
  end

  def create_train_action
    puts "=========================="
    puts "Enter the name of a train:"
    puts "=========================="
    name = ask_user
    return if name == EXIT_PROGRAM

    show_options("What is the type of the train?", ["Passenger", "Cargo"])
    type = ask_user
    return if type == EXIT_PROGRAM

    case type
    when "1"
      return @trains << PassengerTrain.new(name, "passenger")
    when "2"
      return @trains << CargoTrain.new(name, "cargo")
    else
      puts "=========================="
      puts "Wrong type, try again"
      puts "=========================="
      return
    end
  end

  def move_train_action
    if (@trains.size.zero?)
      puts "=========================="
      puts "there is no train to move"
      puts "=========================="
      return
    end

    puts "=========================="
    puts "What train do you want to move?"
    @trains.each_with_index { |train, index| puts "Train #{index + 1}: #{train.number} type: #{train.type}" }
    puts "=========================="

    loop do
      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @trains.size)
        break if user_answer == EXIT_PROGRAM
        puts "=========================="
        puts "Wrong number, try again"
        puts "=========================="
        next
      end

      train = @trains[user_answer - 1]
      move_train(train)
      break
    end
  end

  def move_train(train)
    if (train.route.size.zero?)
      puts "=========================="
      puts "There is no route"
      puts "=========================="
      return
    end
    loop do
      show_options("Choose the action", ["Move forward", "Move back"])

      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

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

    puts "What train do you want to update?"
    @trains.each_with_index { |train, index| puts "Train #{index + 1}: #{train.number} type: #{train.type}" }
    loop do
      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @trains.size)
        break if user_answer == EXIT_PROGRAM
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
      show_options("Choose the action", ["Add a carriage", "Remove a carriage", "Set a route", "Set speed", "Stop the train"])

      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

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
      else
        print_wrong_option
      end
    end
  end

  def add_carriage_to_train(train)
    if (@carriages.size.zero?)
      show_no_subject('carriages')
      return
    end

    puts "List of carriages:"
    @carriages.each_with_index { |carriage, index| puts "Carriage #{index + 1} : #{carriage.name} - #{carriage.type} " }

    puts "Which one would you like to add?"
    loop do
      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @carriages.size)
        print_wrong_option
        next
      end

      carriage = @carriages[user_answer - 1]
      train.add_carriage(carriage)
      return
    end
  end

  def remove_carriage_from_train(train)
    if (train.carriages.size.zero?)
      show_no_subject('carriages')
      return
    else
      train.remove_carriage
      return
    end
  end

  def set_route_to_train(train)
    if (@routes.size.zero?)
      show_no_subject('routes')
      return
    end
    puts "List of routes:"
    @routes.each_with_index { |routes, index| puts "Route #{index + 1} : #{routes.name} " }

    puts "Which one would you like to add?"
    loop do
      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @routes.size)
        print_wrong_option
        next
      end

      route = @routes[user_answer - 1]
      train.add_route(route)
      break
    end
  end
end
