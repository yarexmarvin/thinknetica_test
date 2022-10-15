require_relative './modules/instance_counter'
require_relative './modules/validation'

class Station
  include InstanceCounter
  include Validation

  @@stations = []
  def self.all
    @@stations
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate('station', 'name', name)
    register_instance
  end

  def valid?
    validate('station', 'name', name)
    true
  rescue StandardError
    false
  end

  def iterate_through_trains(&block)
    @trains.each(&block)
  end

  def add_train(train)
    @trains << train
  end

  def get_trains_by_type
    @trains.each_with_object({}) do |train, acc|
      acc[train.type] = acc[train.type].nil? ? 1 : acc[train.type] + 1
    end
  end

  def depart_train(train)
    if @trains.include?(train)
      @trains.delete(train)
      @trains.compact!
    end
  end
end
