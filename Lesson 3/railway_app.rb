

class Station

  attr_reader :name

  def initialize(name)
    @name = name  
    @trains = []
  end

  def trains
    @trains
  end

  def add_train(train)
     puts "#{@name}: New train #{train.number} has just arrived!"
     @trains << train
     puts "#{@name}: total list of trains #{get_trains_by_type}"
  end

  def get_trains_by_type
    @trains.reduce({}) do |acc, train| 
      acc[train.type] = acc[train.type].nil? ?  1 : acc[train.type] + 1 
      acc
    end
  end

  def depart_train(train)
    if(@trains.include?(train)) 
      puts "#{@name}: Train #{train.number} has just departed!"
      @trains.delete(train)
      @trains.compact!
    else
      puts "#{@name}: Error, there is no #{train} train at this station!"
    end
  end
  
end



class Route

  def initialize (start_station, end_station)
    @start = start_station
    @end = end_station
    @stations = []
  end

  def add_station(station_name)
    @stations << station_name
  end

  def remove_station(target_station)
    index = @stations.index(target_station)
    @stations.slice!(index)
    puts "Stations left #{@stations}"
  end

  def get_route
    result = @stations.collect {|station| station}
    result.unshift(@start)
    result.push(@end)
    puts @stations.inspect
    puts result.inspect
    return result
  end

end

class Train 

  attr_reader :station, :number, :carriages, :speed, :type

  def initialize(number, type, carriages=0 )
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
    @station = {}
    @route = {}
  end

  def add_carriage
    if(speed == 0)
       @carriages+=1
       puts "Added 1 carriage, total: #{@carriages}"
    else 
      puts "Cannot add a new carriage when train is moving"
    end

  end

  def remove_carriage
    if(@carriages > 0)
      @carriages -= 1
      puts "Removed 1 carriage, total: #{@carriages}"
    end
  end



  def speed=(speed)
    @speed = speed
    puts "Train #{@number} speed now is #{@speed}"
  end

  def stop
    @speed = 0
    puts "The train has just stopped"
  end

  def add_route(route)
    @route = route
    @station = route[0]
    @station.add_train(self)
    puts "New route added, first station #{@station.name}"
  end

  def to_next_station
    next_index = @route.index(@station) + 1
    
   

    if(next_index == @route.size)
      puts 'You have reached the last station on current route!'
      return
    end
    @station.depart_train(self)
    @station = @route[next_index]
    @station.add_train(self)

    puts "Moved to the next station, current station is #{@station.name}"

  end

  def to_previous_station
    previous_index = @route.index(@station) - 1
    

    if(previous_index == -1)
      puts "You are at the beginning of the route!"
      return
    end
    @station.depart_train(self)
    @station = @route[previous_index]
    @station.add_train(self)

    puts "Moved to the previous station, current station is #{@station.name}"

  end

   
end




station1 = Station.new('Station1');
station2 = Station.new('Station2');
station3 = Station.new('Station3');
station4 = Station.new('Station4');
station5 = Station.new('Station5');
station6 = Station.new('Station6');


route1 = Route.new(station1, station6)
route1.add_station(station2)
route1.add_station(station3)
route1.add_station(station4)
route1.remove_station(station3)
route1.add_station(station5)


train1 = Train.new('train1', 'transport', 3 );
train1.add_route(route1.get_route)

train1.to_next_station
train1.to_previous_station
train1.to_previous_station


train1.speed = 50

puts  "Train carrieges:  #{train1.carriages}"
train1.add_carriage 
puts  "Train carrieges:  #{train1.carriages}"


train1.stop
puts  "Train carrieges:  #{train1.carriages}"
train1.add_carriage 
puts  "Train carrieges:  #{train1.carriages}"

train1.to_next_station
train1.to_next_station
train1.to_next_station
train1.to_next_station
train1.to_next_station



