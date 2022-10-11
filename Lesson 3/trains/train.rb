require_relative "../modules/manufacture.rb"
require_relative "../modules/instance_counter.rb"


class Train
  include Manufacture
  include InstanceCounter

  @@instance_counter = 0

  @@trains = []

  def self.find(number)
    if (@@trains.empty?)
      puts "No trains avalible"
      return
    end
    train = @@trains.find { |find| find.number == number }

    if (train.nil?)
      puts "Train is not found"
    else
      puts train.inspect
    end
  end

  attr_reader :station, :number, :speed, :type, :route

  def initialize(number, type, carriages = [])
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
    @station = {}
    @route = []
    @@trains << self
    register_instance
  end

  def add_carriage(carriage)
    if (speed.zero? && @type == carriage.type)
      @carriages << carriage
      puts "Added 1 carriage: #{carriage.name}, total: #{@carriages.size}"
      return
    else
      puts "Cannot add a new carriage"
    end
  end

  def remove_carriage
    if (@carriages.size.positive?)
      @carriages.pop
      puts "Removed 1 carriage, total: #{@carriages.size}"
      return
    end
  end

  def speed=(speed)
    @speed = speed
    puts "Train #{@number} speed now is #{@speed}"
    return
  end

  def stop
    @speed = 0
    puts "The train has just stopped"
    return
  end

  def add_route(route)
    @route = route.get_route
    @station = @route[0]
    @station.add_train(self)
    puts "New route added, first station #{@station.name}"
    return
  end

  def to_next_station
    next_index = @route.index(@station) + 1

    if (next_index == @route.size)
      puts "You have reached the last station on current route!"
      return
    end
    @station.depart_train(self)
    @station = @route[next_index]
    @station.add_train(self)

    puts "Moved to the next station, current station is #{@station.name}"
    return
  end

  def to_previous_station
    previous_index = @route.index(@station) - 1

    if (previous_index == -1)
      puts "You are at the beginning of the route!"
      return
    end

    @station.depart_train(self)
    @station = @route[previous_index]
    @station.add_train(self)

    puts "Moved to the previous station, current station is #{@station.name}"
    return
  end
end
