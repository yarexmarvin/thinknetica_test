require_relative "../station.rb"
require_relative "../modules/options.rb"
require_relative "../modules/validation.rb"

class StationController
  include Options
  include Validation

  def initialize(stations)
    @stations = stations
    station_controller
  end

  private

  def station_controller
    loop do
      show_options("Choose an action:", ["Get a list of stations", "Create a station", "Amount of stations"])

      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when "1"
        station_list_action
      when "2"
        create_station_action
      when "3"
        Station.instances
      else
        print_wrong_option
      end
    end
  end

  def station_list_action
    if Station.all.size.zero?
      show_no_subject("stations")
      return
    end

    loop do
      puts "==================="
      puts "Stations available:"
      Station.all.each_with_index { |station, index| puts "Station #{index + 1}: #{station.name}" }
      puts "==================="
      puts "Enter a number of a station, if you want to explore more (or type 'back' to move back): "
      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

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
    loop do
      puts "==============================="
      puts "Enter the name of a new station"
      puts "==============================="
      name = ask_user
      break if EXIT_PROGRAM.include?(name)

      validName = valid("station", "name", name)

      unless (validName)
        next
      end

      @stations << Station.new(name)
      puts "A new station has been created!"
      break
    end
  end

  def station_action(station)
    loop do
      show_options("Choose an action:", ["Get the list of trains", "Get the list of traings by type"])

      user_answer = ask_user
      break if EXIT_PROGRAM.include?(user_answer)

      case user_answer
      when "1"
        station_trains_list(station)
      when "2"
        station_trains_list_by_type(station)
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

  def station_trains_list_by_type(station)
    if (station.get_trains_by_type.empty?)
      show_no_subject("trains on this station")
    else
      puts "=========================="
      puts station.get_trains_by_type.inspect
      puts "=========================="
    end
  end
end
