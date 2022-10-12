require_relative "./modules/instance_counter.rb"
require_relative "./modules/validation.rb"

class Route
  include InstanceCounter
  include Validation

  attr_reader :name

  def initialize(name, start_station, end_station, stations_in_between = [])
    @name = name
    @start = start_station
    @end = end_station
    @stations = stations_in_between
    register_instance
    validate("route", "name", name)
  end

  def add_station(station_name)
    @stations << station_name
  end

  def remove_station(target_station)
    index = @stations.index(target_station)
    @stations.slice!(index)
  end

  def get_route
    result = @stations.collect { |station| station }
    result.unshift(@start)
    result.push(@end)
    return result
  end
end
