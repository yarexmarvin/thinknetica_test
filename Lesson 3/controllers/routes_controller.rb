require_relative '../route'
require_relative '../modules/options'
require_relative '../modules/validation'

class RouteController
  include Options
  include Validation

  def initialize(routes, stations)
    @routes = routes
    @stations = stations
    route_controller
  end

  private

  def route_controller
    loop do
      show_options('Choose an action', ['Create a route', 'Get a list routes', 'Amount of routes'])

      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when '1'
        create_route_action
      when '2'
        routes_list_action
      when '3'
        Route.instances
      else
        print_wrong_option
      end
    end
  end

  def create_route_action
    if @stations.size < 2
      show_no_subject('stations to create a route')
      return
    end

    loop do
      puts '============================='
      puts 'Enter the name of a new route'
      puts '============================='
      name = ask_user
      break if EXIT_PROGRAM.include?(name)

      puts '=========================='
      puts 'Choose start point'
      @stations.each_with_index { |station, index| puts "#{index + 1} - Station: #{station.name}" }
      puts '=========================='
      start_station_number = ask_user
      return if EXIT_PROGRAM.include?(start_station_number)

      start_station = @stations[start_station_number.to_i - 1]

      puts '=========================='
      puts 'Choose end point'
      end_stations = @stations.select { |station| station != start_station }
      end_stations.each_with_index { |station, index| puts "#{index + 1} - Station: #{station.name}" }
      puts '=========================='
      end_station_number = ask_user
      return if EXIT_PROGRAM.include?(end_station_number)

      if !end_station_number.to_i.positive? || end_station_number.to_i > end_stations.length
        print_wrong_option
        next
      else
        end_station = end_stations[end_station_number.to_i - 1]
      end

      puts '=========================='
      puts 'If you wish to add stations in between, just enter the numbers in a row with a comma'
      puts '=========================='
      in_between_stations = @stations.select { |station| station != start_station && station != end_station }
      in_between_stations.each_with_index { |station, index| puts " #{index + 1} - Station: #{station.name}" }

      in_between_stations_numbers = gets.chomp.to_s
      return if EXIT_PROGRAM.include?(in_between_stations_numbers)

      if !in_between_stations_numbers == '' && (!in_between_stations_numbers.to_i.positive? || in_between_stations_numbers.to_i > in_between_stations.length)
        print_wrong_option
        next
      else
        stations_in_between = in_between_stations_numbers.split(',').map { |index| in_between_stations[index.to_i - 1] }
      end

      @routes << Route.new(name, start_station, end_station, stations_in_between)
      puts '============================='
      puts 'A new route has been created!'
      puts '============================='
      break
    end
  end

  def routes_list_action
    if @routes.size.zero?
      show_no_subject('routes')
      return
    end

    loop do
      puts '==================='
      puts 'Routes available:'
      @routes.each_with_index { |routes, index| puts "#{index + 1} - Route #{index + 1}: #{routes.name}" }
      puts '==================='
      puts "Enter a number of a route, if you want to explore more (or type 'back' to move back): "
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i
      if !user_answer.positive? || user_answer > @routes.size
        print_wrong_option
        next
      end

      route = @routes[user_answer - 1]
      route_action(route)
    end
  end

  def route_action(route)
    loop do
      show_options('Choose an action for this route', ['Show the route', 'Add stations', 'Delete stations'])

      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when '1'
        puts route.get_route.inspect
      when '2'
        add_station_to_route(route)
      when '3'
        delete_station_from_route(route)
      else
        print_wrong_option
      end
    end
  end

  def delete_station_from_route(route)
    loop do
      puts '===================================='
      puts 'Which station do you wish to delete?'
      puts '===================================='
      current_stations = route.get_route

      available_stations = current_stations.select do |station|
        current_stations[0] != station && current_stations[current_stations.size - 1] != station
      end

      if available_stations.size.zero?
        show_no_subject('stations to delete')
        return
      end

      puts '=========================='
      available_stations.each_with_index do |station, index|
        puts "#{index + 1} - Station #{index + 1}: #{station.name}"
      end
      puts '=========================='

      user_answer = ask_user

      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i

      if !user_answer.positive? || user_answer > available_stations.size
        print_wrong_option
        next
      end

      station = @stations.find { |st| st == available_stations[user_answer.to_i - 1] }
      route.remove_station(station)
      puts '#########################################################################'
      puts "The station #{station.name} has been deleted from the route #{route.name}"
      puts '#########################################################################'
      break
    end
  end

  def add_station_to_route(route)
    if @stations.size <= 2
      show_no_subject('stations out there')
      return
    end

    loop do
      puts '======================'
      puts 'Choose from available:'
      puts '======================'
      current_stations = route.get_route
      available_stations = @stations.select { |station| !current_stations.include?(station) }

      if available_stations.size.zero?
        show_no_subject('avaliable stations to choose')
        return
      end

      puts '=========================='
      available_stations.each_with_index do |station, index|
        puts "#{index + 1} - Station #{index + 1}: #{station.name}" unless current_stations.include?(station)
      end
      puts '=========================='

      user_answer = ask_user

      break if EXIT_PROGRAM.include?(user_answer)

      user_answer = user_answer.to_i

      if !user_answer.positive? || user_answer > available_stations.size
        print_wrong_option
        next
      end

      station = @stations.find { |st| st == available_stations[user_answer.to_i - 1] }
      route.add_station(station)
      puts '#####################################################################'
      puts "The station #{station.name} has been added to the route #{route.name}"
      puts '#####################################################################'
      break
    end
  end
end
