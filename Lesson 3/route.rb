require_relative './station'
require_relative './modules/instance_counter'
require_relative "./modules/accessor"
require_relative './modules/validation'

class Route
  include InstanceCounter
  include Validation
  include Accessor

  ROUTE_NAME = /^\w+(\d+|\w+)$/i.freeze

  validate :name, :format, ROUTE_NAME
  validate :start, :type, Station
  validate :end, :type, Station

  attr_reader :name

  def initialize(name, start_station, end_station, stations_in_between = [])
    @name = name
    @start = start_station
    @end = end_station
    @stations = stations_in_between
    validate!
    register_instance
  end

  def add_station(station_name)
    @stations << station_name
  end

  def remove_station(target_station)
    index = @stations.index(target_station)
    @stations.slice!(index)
  end

  def full_route
    result = @stations.collect { |station| station }
    result.unshift(@start)
    result.push(@end)
    result
  end
end
