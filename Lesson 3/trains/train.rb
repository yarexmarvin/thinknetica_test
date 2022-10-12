require_relative "../modules/manufacture.rb"
require_relative "../modules/instance_counter.rb"
require_relative "../modules/validation.rb"

class Train
  include Manufacture
  include InstanceCounter
  include Validation
  @@trains = []

  def self.find(number)
    if (@@trains.empty?)
      return nil
    end
    @@trains.find { |find| find.number == number }
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
    validate("train", "number", number)
  end

  def add_carriage(carriage)
    if (speed.zero? && @type == carriage.type)
      @carriages << carriage
    end
  end

  def remove_carriage
    if (@carriages.size.positive?)
      @carriages.pop
    end
  end

  def speed=(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def add_route(route)
    @route = route.get_route
    @station = @route[0]
    @station.add_train(self)
  end

  def to_next_station
    next_index = @route.index(@station) + 1

    unless (next_index == @route.size)
      @station.depart_train(self)
      @station = @route[next_index]
      @station.add_train(self)
    end
  end

  def to_previous_station
    previous_index = @route.index(@station) - 1

    unless (previous_index == -1)
      @station.depart_train(self)
      @station = @route[previous_index]
      @station.add_train(self)
    end
  end
end
