require_relative '../modules/manufacture'
require_relative '../modules/instance_counter'
require_relative '../modules/validation'

class Train
  include Manufacture
  include InstanceCounter
  include Validation
  @@trains = []

  def self.find(number)
    return nil if @@trains.empty?

    @@trains.find { |find| find.number == number }
  end

  attr_accessor :speed
  attr_reader :station, :number, :type, :route, :carriages

  def initialize(number, type, carriages = [])
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
    @station = {}
    @route = []

    validate('train', 'number', number)

    @@trains << self
    register_instance
  end

  def valid?
    validate('train', 'number', number)
    true
  rescue StandardError
    false
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
    @route = route.get_route
    @station = @route[0]
    @station.add_train(self)
  end

  def to_next_station
    next_index = @route.index(@station) + 1

    unless next_index == @route.size
      @station.depart_train(self)
      @station = @route[next_index]
      @station.add_train(self)
    end
  end

  def to_previous_station
    previous_index = @route.index(@station) - 1

    unless previous_index == -1
      @station.depart_train(self)
      @station = @route[previous_index]
      @station.add_train(self)
    end
  end
end
