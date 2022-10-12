module Validation
  ROUTE_NAME = /^\w+(\d+|\w+)$/i
  CARRIAGE_NAME = /^\w+(\d+|\w+)$/i
  STATION_NAME = /^\w{2,}(\d+|\w+)$/i
  TRAIN_NUMBER = /^(\d|[a-z]){3}\-?(\d|[a-z]){2}$/i

  def valid(item, attr, value)
    begin
      validate(item, attr, value)
      return true
    rescue
      puts '||||||||||||||||||||||||||||||||||||||||||||||||'
      puts "Invalid format for #{item}'s attribute: #{attr}"
      puts '||||||||||||||||||||||||||||||||||||||||||||||||'
      return false
    end
  end

  def validate(item, attr, value)
    case item
    when "train"
      train_validation(attr, value)
    when "route"
      route_validation(attr, value)
    when "station"
      station_validation(attr, value)
    when "carriage"
      carriage_validation(attr, value)
    else
      puts "Undefined instance"
    end
  end

  private

  def train_validation(attr, value)
    case attr
    when "number"
      raise "Invalid number for the train" unless value =~ TRAIN_NUMBER
    else
      puts "Invalid attribute of a train instance"
    end
  end

  def route_validation(attr, value)
    case attr
    when "name"
      raise "Invalid name for the route" unless value =~ ROUTE_NAME
    else
      puts "Invalid attribute of a route instance"
    end
  end

  def station_validation(attr, value)
    case attr
    when "name"
      raise "Invalid name for the station" unless value =~ STATION_NAME
    else
      puts "Invalid attribute of a station instance"
    end
  end

  def carriage_validation(attr, value)
    case attr
    when "name"
      raise "Invalid name for the carriage" unless value =~ CARRIAGE_NAME
    else
      puts "Invalid attribute of a carriage instance"
    end
  end
end
