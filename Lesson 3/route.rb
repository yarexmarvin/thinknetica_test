require_relative './modules/instance_counter'
require_relative './modules/validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :name

  def initialize(name, start_station, end_station, stations_in_between = [])
    @name = name
    @start = start_station
    @end = end_station
    @stations = stations_in_between
    validate('route', 'name', name)
    register_instance
  end

  def valid?
    validate('route', 'name', name)
    true
  rescue StandardError
    false
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
    result
  end
end
