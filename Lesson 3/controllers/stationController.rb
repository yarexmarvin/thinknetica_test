class StationController
  EXIT_PROGRAM = "back"

  def initialize(stations)
    @stations = stations
    station_controller
  end

  private
  def station_controller
    loop do
      puts "Choose an action:"
      puts "1 - get a list of stations"
      puts "2 - create a station"
      puts "Enter 'back' to move back"

      user_answer = gets.chomp
      break if user_answer == EXIT_PROGRAM

      case user_answer
      when "1"
        station_list_action
      when "2"
        create_station_action
      else
        puts "Undefined"
      end
    end
  end

  def station_list_action
    if @stations.size.zero?
      puts "======================"
      puts "There are no stations!"
      puts "======================"
      return
    end

    puts "==================="
    puts "Stations available:"
    @stations.each_with_index { |station, index| puts "Station #{index + 1} - #{station.name}" }
    puts "==================="

    loop do
      puts "Enter a number of a station, if you want to explore more (or type 'back' to move back): "
      user_answer = gets.chomp
      break if user_answer == EXIT_PROGRAM

      user_answer = user_answer.to_i
      if (!user_answer.positive? || user_answer > @stations.size)
        puts "======================="
        puts "Wrong number, try again"
        puts "======================="
        next
      end

      station = @stations[user_answer.to_i - 1]
      station_action(station)
    end
  end

  def create_station_action
    puts "Enter the name of a new station"
    name = gets.chomp

    @stations << Station.new(name)
    puts "A new station has been created!"
  end

  def station_action(station)
    loop do
      puts "Choose an action:"
      puts "1 - get the list of trains"

      user_answer = gets.chomp
      break if user_answer == EXIT_PROGRAM

      case user_answer
      when "1"
        station_trains_list(station)
      else
        puts "Undefined"
      end
    end
  end

  def station_trains_list(station)
    if (station.trains.size.zero?)
      puts "==================================="
      puts "There are no trains on this station"
      puts "==================================="
    else
      puts "=========================="
      station.trains.each_with_index { |train, index| puts "Train #{index + 1} - #{train.number} - #{train.type}" }
      puts "=========================="
    end
  end
end
