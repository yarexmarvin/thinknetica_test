class TrainController
  EXIT_PROGRAM = "back"

  def initialize(trains, routes, carriages)
    @trains = trains
    @routes = routes
    @carriages = carriages
    train_controller
  end

  private
  def train_controller
    loop do
      puts "Choose an action: "
      puts "1 - create"
      puts "2 - update"
      puts "3 - move"
      puts "Enter 'back' to move back"

      user_answer = gets.chomp
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
    name = gets.chomp
    return if name == EXIT_PROGRAM
    puts "=========================="
    puts "Enter the type of a train (passenger/cargo)"
    puts "1 - Passenger"
    puts "2 - Cargo"
    puts "=========================="

    type = gets.chomp
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
      user_answer = gets.chomp
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
      puts "Choose the action"
      puts "1 - move forward to the next station"
      puts "2 - move back to the previous station"
      puts "Enter 'back' to move back"

      user_answer = gets.chomp
      break if user_answer == EXIT_PROGRAM

      case user_answer
      when "1"
        train.to_next_station
      when "2"
        train.to_previous_station
      else
        puts "Wrong number"
        break if user_answer == EXIT_PROGRAM
      end
    end
  end

  def update_train_action
    if (@trains.size.zero?)
      puts "============================"
      puts "there is no train to update"
      puts "============================"
      return
    end

    puts "What train do you want to update?"
    @trains.each_with_index { |train, index| puts "Train #{index + 1}: #{train.number} type: #{train.type}" }
    loop do
      user_answer = gets.chomp
      break if user_answer == EXIT_PROGRAM

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @trains.size)
        break if user_answer == EXIT_PROGRAM
        puts "======================="
        puts "Wrong number, try again"
        puts "======================="
        next
      end

      train = @trains[user_answer - 1]
      update_train(train)
      break
    end
  end

  def update_train(train)
    loop do
      puts "Choose the action:"
      puts "1 - add carriage"
      puts "2 - remove carriage"
      puts "3 - set a route"
      puts "4 - set speed"
      puts "5 - stop"
      puts "Enter 'back' to move back"

      user_answer = gets.chomp
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
        speed = gets.chomp.to_i
        train.speed = speed
      when "5"
        train.stop
      else
        puts "Undefined"
      end
    end
  end

  def add_carriage_to_train(train)
    if (@carriages.size.zero?)
      puts "=========================="
      puts "There are no carriages"
      puts "=========================="
      return
    end

    puts "List of carriages:"
    @carriages.each_with_index { |carriage, index| puts "Carriage #{index + 1} : #{carriage.name} - #{carriage.type} " }

    puts "Which one would you like to add?"
    loop do
      user_answer = gets.chomp
      break if user_answer == EXIT_PROGRAM

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @carriages.size)
        puts "Wrong number, try again"
        next
      end

      carriage = @carriages[user_answer - 1]
      train.add_carriage(carriage)
    end
  end

  def remove_carriage_from_train(train)
    if (train.carriages.size.zero?)
      puts "=========================="
      puts "There are no carriages"
      puts "=========================="
      return
    else
      train.remove_carriage
      return
    end
  end

  def set_route_to_train(train)
    if (@routes.size.zero?)
      puts "There are no routes"
      return
    end
    puts "List of routes:"
    @routes.each_with_index { |routes, index| puts "Route #{index + 1} : #{routes.name} " }

    puts "Which one would you like to add?"
    loop do
      user_answer = gets.chomp
      break if user_answer == EXIT_PROGRAM

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @routes.size)
        puts "Wrong number, try again"
        next
      end

      route = @routes[user_answer - 1]
      train.add_route(route)
      break
    end
  end
end
