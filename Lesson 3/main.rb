require "./route.rb"
require "./station.rb"
require "./trains/CargoTrain.rb"
require "./trains/PassengerTrain.rb"
require "./carriages/passengerCarriage.rb"
require "./carriages/cargoCarriage.rb"
require_relative "./controllers/carriageController.rb"
require_relative "./controllers/routeController.rb"
require_relative "./controllers/stationController.rb"
require_relative "./controllers/trainController.rb"

class Railroad
  EXIT_PROGRAM = "back"

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  def start_app
    loop do
      puts "Choose the subject"
      puts "1 - trains"
      puts "2 - routes"
      puts "3 - carriages"
      puts "4 - stations"
      puts "Enter 'back' to exit the program"

      user_answer = gets.chomp
      break if user_answer == EXIT_PROGRAM

      case user_answer
      when "1"
        TrainController.new(@trains, @routes, @carriages)
      when "2"
        RouteController.new(@routes, @stations)
      when "3"
        CarriageController.new(@carriages)
      when "4"
        StationController.new(@stations)
      else
        puts "Undefined"
      end
    end
  end

  # def train_controller
  #   loop do
  #     puts "Choose an action: "
  #     puts "1 - create"
  #     puts "2 - update"
  #     puts "3 - move"
  #     puts "Enter 'back' to move back"

  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     case user_answer
  #     when "1"
  #       create_train_action
  #     when "2"
  #       update_train_action
  #     when "3"
  #       move_train_action
  #     else
  #       puts "Undefined"
  #       break if user_answer == EXIT_PROGRAM
  #     end
  #   end
  # end

  # def create_train_action
  #   puts "=========================="
  #   puts "Enter the name of a train:"
  #   puts "=========================="
  #   name = gets.chomp
  #   return if name == EXIT_PROGRAM
  #   puts "=========================="
  #   puts "Enter the type of a train (passenger/cargo)"
  #   puts "1 - Passenger"
  #   puts "2 - Cargo"
  #   puts "=========================="

  #   type = gets.chomp
  #   return if type == EXIT_PROGRAM

  #   case type
  #   when "1"
  #     return @trains << PassengerTrain.new(name, "passenger")
  #   when "2"
  #     return @trains << CargoTrain.new(name, "cargo")
  #   else
  #     puts "=========================="
  #     puts "Wrong type, try again"
  #     puts "=========================="
  #     return
  #   end
  # end

  # def move_train_action
  #   if (@trains.size.zero?)
  #     puts "=========================="
  #     puts "there is no train to move"
  #     puts "=========================="
  #     return
  #   end

  #   puts "=========================="
  #   puts "What train do you want to move?"
  #   @trains.each_with_index { |train, index| puts "Train #{index + 1}: #{train.number} type: #{train.type}" }
  #   puts "=========================="

  #   loop do
  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     user_answer = user_answer.to_i
  #     if (!user_answer.positive? || user_answer > @trains.size)
  #       break if user_answer == EXIT_PROGRAM
  #       puts "=========================="
  #       puts "Wrong number, try again"
  #       puts "=========================="
  #       next
  #     end

  #     train = @trains[user_answer - 1]
  #     move_train(train)
  #     break
  #   end
  # end

  # def move_train(train)
  #   if (train.route.size.zero?)
  #     puts "=========================="
  #     puts "There is no route"
  #     puts "=========================="
  #     return
  #   end
  #   loop do
  #     puts "Choose the action"
  #     puts "1 - move forward to the next station"
  #     puts "2 - move back to the previous station"
  #     puts "Enter 'back' to move back"

  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     case user_answer
  #     when "1"
  #       train.to_next_station
  #     when "2"
  #       train.to_previous_station
  #     else
  #       puts "Wrong number"
  #       break if user_answer == EXIT_PROGRAM
  #     end
  #   end
  # end

  # def update_train_action
  #   if (@trains.size.zero?)
  #     puts "============================"
  #     puts "there is no train to update"
  #     puts "============================"
  #     return
  #   end

  #   puts "What train do you want to update?"
  #   @trains.each_with_index { |train, index| puts "Train #{index + 1}: #{train.number} type: #{train.type}" }
  #   loop do
  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     user_answer = user_answer.to_i
  #     if (!user_answer.positive? || user_answer > @trains.size)
  #       break if user_answer == EXIT_PROGRAM
  #       puts "======================="
  #       puts "Wrong number, try again"
  #       puts "======================="
  #       next
  #     end

  #     train = @trains[user_answer - 1]
  #     update_train(train)
  #     break
  #   end
  # end

  # def update_train(train)
  #   loop do
  #     puts "Choose the action:"
  #     puts "1 - add carriage"
  #     puts "2 - remove carriage"
  #     puts "3 - set a route"
  #     puts "4 - set speed"
  #     puts "5 - stop"
  #     puts "Enter 'back' to move back"

  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     case user_answer
  #     when "1"
  #       add_carriage_to_train(train)
  #     when "2"
  #       train.remove_carriage
  #     when "3"
  #       set_route_to_train(train)
  #     when "4"
  #       puts "Enter a speed:"
  #       speed = gets.chomp.to_i
  #       train.speed = speed
  #     when "5"
  #       train.stop
  #     else
  #       puts "Undefined"
  #     end
  #   end
  # end

  # def add_carriage_to_train(train)
  #   if (@carriages.size.zero?)
  #     puts "=========================="
  #     puts "There are no carriages"
  #     puts "=========================="
  #     return
  #   end

  #   puts "List of carriages:"
  #   @carriages.each_with_index { |carriage, index| puts "Carriage #{index + 1} : #{carriage.name} - #{carriage.type} " }

  #   puts "Which one would you like to add?"
  #   loop do
  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     user_answer = user_answer.to_i
  #     if (!user_answer.positive? || user_answer > @carriages.size)
  #       puts "Wrong number, try again"
  #       next
  #     end

  #     carriage = @carriages[user_answer - 1]
  #     train.add_carriage(carriage)
  #   end
  # end

  # def remove_carriage_from_train(train)
  #   if (train.carriages.size.zero?)
  #     puts "=========================="
  #     puts "There are no carriages"
  #     puts "=========================="
  #     return
  #   else
  #     train.remove_carriage
  #     return
  #   end
  # end

  # def set_route_to_train(train)
  #   if (@routes.size.zero?)
  #     puts "There are no routes"
  #     return
  #   end
  #   puts "List of routes:"
  #   @routes.each_with_index { |routes, index| puts "Route #{index + 1} : #{routes.name} " }

  #   puts "Which one would you like to add?"
  #   loop do
  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     user_answer = user_answer.to_i
  #     if (!user_answer.positive? || user_answer > @routes.size)
  #       puts "Wrong number, try again"
  #       next
  #     end

  #     route = @routes[user_answer - 1]
  #     train.add_route(route)
  #     break
  #   end
  # end

  # def carriage_controller
  #   loop do
  #     puts "Choose an action:"
  #     puts "1 - create a carriage"
  #     puts "2 - show the list of carriages"
  #     puts "Enter 'back' to move back"

  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     case user_answer
  #     when "1"
  #       create_carriage_action
  #     when "2"
  #       carriages_list_action
  #     else
  #       puts "Undefined"
  #     end
  #   end
  # end

  # def create_carriage_action
  #   puts "=========================="
  #   puts "Enter the name of a carriage:"
  #   puts "=========================="
  #   name = gets.chomp
  #   puts "=========================="
  #   puts "Enter the type of a carriage (passenger/cargo)"
  #   puts "1 - Passenger"
  #   puts "2 - Cargo"
  #   puts "=========================="
  #   type = gets.chomp

  #   case type
  #   when "1"
  #     return @carriages << PassengerCarriage.new(name, "passenger")
  #   when "2"
  #     return @carriages << CargoCarriage.new(name, "cargo")
  #   else
  #     puts "=========================="
  #     puts "Wrong type, try again"
  #     puts "=========================="
  #     return
  #   end
  # end

  # def carriages_list_action
  #   if (@carriages.size.zero?)
  #     puts "=========================="
  #     puts "There are no carriages"
  #     puts "=========================="
  #     return
  #   end
  #   puts "=========================="
  #   puts "List of carriages:"
  #   @carriages.each_with_index { |carriage, index| puts "Carriage #{index + 1} : #{carriage.name} - #{carriage.type} " }
  #   puts "=========================="
  # end

  # def route_controller
  #   loop do
  #     puts "Choose an action:"
  #     puts "1 - create a route"
  #     puts "2 - get a list routes"
  #     puts "Enter 'back' to move back"

  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     case user_answer
  #     when "1"
  #       create_route_action
  #     when "2"
  #       routes_list_action
  #     else
  #       puts "Undefined"
  #     end
  #   end
  # end

  # def create_route_action
  #   if (@stations.size < 2)
  #     puts "================================"
  #     puts "There is not enough stations to create a route"
  #     puts "================================"
  #     return
  #   end

  #   puts "Enter the name of a new route"
  #   name = gets.chomp

  #   puts "=========================="
  #   puts "Choose start point"
  #   @stations.each_with_index { |station, index| puts "Station #{index + 1} - #{station.name}" }
  #   puts "=========================="
  #   start_station_number = gets.chomp
  #   start_station = @stations[start_station_number.to_i - 1]

  #   puts start_station.inspect

  #   puts "=========================="
  #   puts "Choose end point"
  #   @stations.each_with_index { |station, index| puts "Station #{index + 1} - #{station.name}" }
  #   puts "=========================="
  #   end_station_number = gets.chomp
  #   end_station = @stations[end_station_number.to_i - 1]

  #   puts end_station.inspect

  #   puts "=========================="
  #   puts "If you wish to add stations in between, just enter the numbers in a row with a comma"
  #   puts "=========================="
  #   in_between_stations = gets.chomp.to_s
  #   stations_in_between = in_between_stations.split(",").map { |index| @stations[index.to_i - 1] unless @stations[index.to_i - 1].nil? || index.to_i == start_station || index.to_i == end_station }

  #   puts stations_in_between.inspect

  #   @routes << Route.new(name, start_station, end_station, stations_in_between)
  #   puts "============================="
  #   puts "A new route has been created!"
  #   puts "============================="
  # end

  # def routes_list_action
  #   if @routes.size.zero?
  #     puts "====================="
  #     puts "There are no routes!"
  #     puts "====================="
  #     return
  #   end

  #   loop do
  #     puts "==================="
  #     puts "Routes available:"
  #     @routes.each_with_index { |routes, index| puts "Route #{index + 1} - #{routes.name}" }
  #     puts "==================="
  #     puts "Enter a number of a route, if you want to explore more (or type exit): "
  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM
  #     user_answer = user_answer.to_i
  #     if (!user_answer.positive? || user_answer > @routes.size)
  #       puts "======================="
  #       puts "Wrong number, try again"
  #       puts "======================="
  #       next
  #     end

  #     route = @routes[user_answer - 1]
  #     route_action(route)
  #   end
  # end

  # def route_action(route)
  #   loop do
  #     puts "Choose an action for this route:"
  #     puts "1 - show route"
  #     puts "2 - add stations"
  #     puts "3 - delete stations"
  #     puts "Enter 'back' to move back"

  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     case user_answer
  #     when "1"
  #       puts route.get_route.inspect
  #       break
  #     when "2"
  #       add_station_to_route(route)
  #     when "3"
  #       delete_station_from_route(route)
  #     else
  #       puts "Undefined"
  #     end
  #   end
  # end

  # def delete_station_from_route(route)
  #   loop do
  #     puts "Which station do you wish to delete"
  #     current_stations = route.get_route

  #     puts current_stations.inspect

  #     available_stations = current_stations.select { |station| current_stations[0] != station && current_stations[current_stations.size - 1] != station }

  #     if (available_stations.size.zero?)
  #       puts "==============================="
  #       puts "There is no  stations to delete"
  #       puts "==============================="
  #       return
  #     end

  #     puts "=========================="
  #     available_stations.each_with_index { |station, index| puts "Station #{index + 1} - #{station.name}" }
  #     puts "=========================="

  #     user_answer = gets.chomp

  #     break if user_answer == EXIT_PROGRAM
  #     user_answer = user_answer.to_i

  #     if (!user_answer.positive? || user_answer > available_stations.size)
  #       puts "======================="
  #       puts "Wrong number, try again"
  #       puts "======================="
  #       next
  #     end

  #     station = @stations.find { |st| st == available_stations[user_answer.to_i - 1] }
  #     route.remove_station(station)
  #     break
  #   end
  # end

  # def add_station_to_route(route)
  #   if (@stations.size <= 2)
  #     puts "=============================="
  #     puts "Not enought stations out there"
  #     puts "=============================="
  #     return
  #   end

  #   loop do
  #     puts "======================"
  #     puts "Choose from available:"
  #     current_stations = route.get_route
  #     available_stations = @stations.select { |station| !current_stations.include?(station) }

  #     if (available_stations.size.zero?)
  #       puts "========================================"
  #       puts "There is no avaliable stations to choose"
  #       puts "========================================"
  #       return
  #     end

  #     puts "=========================="
  #     available_stations.each_with_index { |station, index| puts "Station #{index + 1} - #{station.name}" unless current_stations.include?(station) }
  #     puts "=========================="

  #     user_answer = gets.chomp

  #     break if user_answer == EXIT_PROGRAM
  #     user_answer = user_answer.to_i

  #     if (!user_answer.positive? || user_answer > available_stations.size)
  #       puts "======================="
  #       puts "Wrong number, try again"
  #       puts "======================="
  #       next
  #     end

  #     station = @stations.find { |st| st == available_stations[user_answer.to_i - 1] }
  #     route.add_station(station)
  #     break
  #   end
  # end

  # def station_controller
  #   loop do
  #     puts "Choose an action:"
  #     puts "1 - get a list of stations"
  #     puts "2 - create a station"
  #     puts "Enter 'back' to move back"

  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     case user_answer
  #     when "1"
  #       station_list_action
  #     when "2"
  #       create_station_action
  #     else
  #       puts "Undefined"
  #     end
  #   end
  # end

  # private

  # def station_list_action
  #   if @stations.size.zero?
  #     puts "======================"
  #     puts "There are no stations!"
  #     puts "======================"
  #     return
  #   end

  #   puts "==================="
  #   puts "Stations available:"
  #   @stations.each_with_index { |station, index| puts "Station #{index + 1} - #{station.name}" }
  #   puts "==================="

  #   loop do
  #     puts "Enter a number of a station, if you want to explore more (or type exit): "
  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     user_answer = user_answer.to_i
  #     if (!user_answer.positive? || user_answer > @stations.size)
  #       puts "======================="
  #       puts "Wrong number, try again"
  #       puts "======================="
  #       next
  #     end

  #     station = @stations[user_answer.to_i - 1]
  #     station_action(station)
  #   end
  # end

  # def create_station_action
  #   puts "Enter the name of a new station"
  #   name = gets.chomp

  #   @stations << Station.new(name)
  #   puts "A new station has been created!"
  # end

  # def station_action(station)
  #   loop do
  #     puts "Choose an action:"
  #     puts "1 - get the list of trains"

  #     user_answer = gets.chomp
  #     break if user_answer == EXIT_PROGRAM

  #     case user_answer
  #     when "1"
  #       station_trains_list(station)
  #     else
  #       puts "Undefined"
  #     end
  #   end
  # end

  # def station_trains_list(station)
  #   if (station.trains.size.zero?)
  #     puts "==================================="
  #     puts "There are no trains on this station"
  #     puts "==================================="
  #   else
  #     puts "=========================="
  #     station.trains.each_with_index { |train, index| puts "Train #{index + 1} - #{train.number} - #{train.type}" }
  #     puts "=========================="
  #   end
  # end
end

app1 = Railroad.new
app1.start_app
