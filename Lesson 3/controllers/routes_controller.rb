require_relative '../route.rb'
require_relative "../modules/options_module.rb"

class RouteController
  include Options

  def initialize(routes, stations)
    @routes = routes
    @stations = stations
    route_controller
  end

  private

  def route_controller
    loop do
      show_options("Choose an action", ["Create a route", "Get a list routes"])

      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

      case user_answer
      when "1"
        create_route_action
      when "2"
        routes_list_action
      else
        print_wrong_option
      end
    end
  end

  def create_route_action
    if (@stations.size < 2)
      show_no_subject("stations to create a route")
      return
    end

    puts "Enter the name of a new route"
    name = ask_user
    return if name == EXIT_PROGRAM

    puts "=========================="
    puts "Choose start point"
    @stations.each_with_index { |station, index| puts "#{index + 1} - Station: #{station.name}" }
    puts "=========================="
    start_station_number = ask_user
    return if start_station_number == EXIT_PROGRAM
    start_station = @stations[start_station_number.to_i - 1]

    puts "=========================="
    puts "Choose end point"
    end_stations = @stations.select { |station| station != start_station }
    end_stations.each_with_index { |station, index| puts "#{index + 1} - Station: #{station.name}" }
    puts "=========================="
    end_station_number = ask_user
    return if end_station_number == EXIT_PROGRAM
    end_station = end_stations[end_station_number.to_i - 1]

    puts "=========================="
    puts "If you wish to add stations in between, just enter the numbers in a row with a comma"
    puts "=========================="
    in_between_stations = @stations.select { |station| station != start_station && station != end_station }
    in_between_stations.each_with_index { |station, index| puts " #{index + 1} - Station: #{station.name}" }

    in_between_stations_numbers = ask_user.to_s
    return if in_between_stations_numbers == EXIT_PROGRAM

    stations_in_between = in_between_stations_numbers.split(",").map { |index| in_between_stations[index.to_i - 1] }

    @routes << Route.new(name, start_station, end_station, stations_in_between)
    puts "============================="
    puts "A new route has been created!"
    puts "============================="
  end

  def routes_list_action
    if @routes.size.zero?
      show_no_subject("routes")
      return
    end

    loop do
      puts "==================="
      puts "Routes available:"
      @routes.each_with_index { |routes, index| puts "Route #{index + 1} - #{routes.name}" }
      puts "==================="
      puts "Enter a number of a route, if you want to explore more (or type 'back' to move back): "
      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @routes.size)
        print_wrong_option
        next
      end

      route = @routes[user_answer - 1]
      route_action(route)
    end
  end

  def route_action(route)
    loop do
      show_options("Choose an action for this route", ["Show the route", "Add stations", "Delete stations"])

      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

      case user_answer
      when "1"
        puts route.get_route.inspect
        break
      when "2"
        add_station_to_route(route)
      when "3"
        delete_station_from_route(route)
      else
        print_wrong_option
      end
    end
  end

  def delete_station_from_route(route)
    loop do
      puts "Which station do you wish to delete?"
      current_stations = route.get_route

      puts current_stations.inspect

      available_stations = current_stations.select { |station| current_stations[0] != station && current_stations[current_stations.size - 1] != station }

      if (available_stations.size.zero?)
        show_no_subject("stations to delete")
        return
      end

      puts "=========================="
      available_stations.each_with_index { |station, index| puts "Station #{index + 1} - #{station.name}" }
      puts "=========================="

      user_answer = ask_user

      break if user_answer == EXIT_PROGRAM
      user_answer = user_answer.to_i

      if (!user_answer.positive? || user_answer > available_stations.size)
        print_wrong_option
        next
      end

      station = @stations.find { |st| st == available_stations[user_answer.to_i - 1] }
      route.remove_station(station)
      break
    end
  end

  def add_station_to_route(route)
    if (@stations.size <= 2)
      show_no_subject("stations out there")
      return
    end

    loop do
      puts "Choose from available:"
      current_stations = route.get_route
      available_stations = @stations.select { |station| !current_stations.include?(station) }

      if (available_stations.size.zero?)
        show_no_subject("avaliable stations to choose")
        return
      end

      puts "=========================="
      available_stations.each_with_index { |station, index| puts "Station #{index + 1} - #{station.name}" unless current_stations.include?(station) }
      puts "=========================="

      user_answer = ask_user

      break if user_answer == EXIT_PROGRAM
      user_answer = user_answer.to_i

      if (!user_answer.positive? || user_answer > available_stations.size)
        print_wrong_option
        next
      end

      station = @stations.find { |st| st == available_stations[user_answer.to_i - 1] }
      route.add_station(station)
      break
    end
  end
end
