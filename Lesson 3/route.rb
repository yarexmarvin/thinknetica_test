class Route
  attr_reader :name

  def initialize(name, start_station, end_station, stations_in_between = [])
    @name = name
    @start = start_station
    @end = end_station
    @stations = stations_in_between
  end

  def add_station(station_name)
    @stations << station_name
  end

  def remove_station(target_station)
    puts target_station.inspect
    puts @stations.inspect
    index = @stations.index(target_station)
    @stations.slice!(index)
    puts "Stations left #{@stations}"
  end

  def get_route
    result = @stations.collect { |station| station }
    result.unshift(@start)
    result.push(@end)
    return result
  end
end
