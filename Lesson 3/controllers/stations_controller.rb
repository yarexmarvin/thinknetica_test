require_relative "../modules/options_module.rb"

class StationController
  include Options

  def initialize(stations)
    @stations = stations
    station_controller
  end

  private

  def station_controller
    loop do
      show_options("Choose an action:", ["Get a list of stations", "Create a station"])

      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

      case user_answer
      when "1"
        station_list_action
      when "2"
        create_station_action
      else
        print_wrong_option
      end
    end
  end

  def station_list_action
    if @stations.size.zero?
      show_no_subject("stations")
      return
    end

    puts "==================="
    puts "Stations available:"
    @stations.each_with_index { |station, index| puts "Station #{index + 1} - #{station.name}" }
    puts "==================="

    loop do
      puts "Enter a number of a station, if you want to explore more (or type 'back' to move back): "
      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @stations.size)
        print_wrong_option
        next
      end

      station = @stations[user_answer.to_i - 1]
      station_action(station)
    end
  end

  def create_station_action
    puts "Enter the name of a new station"
    name = ask_user

    @stations << Station.new(name)
    puts "A new station has been created!"
  end

  def station_action(station)
    loop do
      show_options("Choose an action:", ["Get the list of trains"])

      user_answer = ask_user
      break if user_answer == EXIT_PROGRAM

      case user_answer
      when "1"
        station_trains_list(station)
      else
        print_wrong_option
      end
    end
  end

  def station_trains_list(station)
    if (station.trains.size.zero?)
      show_no_subject("trains on this station")
    else
      puts "=========================="
      station.trains.each_with_index { |train, index| puts "Train #{index + 1} - #{train.number} - #{train.type}" }
      puts "=========================="
    end
  end
end
