require_relative "../modules/manufacture"
require_relative "../modules/instance_counter"
require_relative "../modules/validation"
require_relative "../modules/accessor"


class Train
  include Manufacture
  include InstanceCounter
  include Validation
  include Accessor

  TRAIN_NUMBER = /^(\d|[a-z]){3}-?(\d|[a-z]){2}$/i.freeze


  @@trains = []

  def self.find(number)
    return nil if @@trains.empty?

    @@trains.find { |find| find.number == number }
  end

  attr_accessor :speed
  attr_reader :station, :number, :type, :route, :carriages

  validate :number, :format, TRAIN_NUMBER
  validate :type, :presence
  validate :type, :type, String
  validate :speed, :positive
  validate :speed, :type, Integer

  def initialize(number, type, carriages = [])
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
    @station = {}
    @route = []

    validate!

    @@trains << self
    register_instance
  end

  def iterate_through_carriages(&block)
    @carriages.each(&block)
  end

  def add_carriage(carriage)
    @carriages << carriage if speed.zero? && @type == carriage.type
  end

  def remove_carriage
    @carriages.pop if @carriages.size.positive? && @speed.zero?
  end

  def stop
    @speed = 0
  end

  def add_route(route)
    @route = route.full_route
    @station = @route[0]
    @station.add_train(self)
  end

  def to_next_station
    next_index = @route.index(@station) + 1

    return if next_index == @route.size

    @station.depart_train(self)
    @station = @route[next_index]
    @station.add_train(self)
  end

  def to_previous_station
    previous_index = @route.index(@station) - 1

    return if previous_index == -1

    @station.depart_train(self)
    @station = @route[previous_index]
    @station.add_train(self)
  end
end
