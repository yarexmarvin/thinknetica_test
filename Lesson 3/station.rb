require_relative "./modules/instance_counter.rb"
require_relative "./modules/validation.rb"

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
    validate("station", "name", name)
    register_instance
  end

  def valid?
    begin
      validate("station", "name", name)
      true
    rescue
      false
    end
  end

  def iterate_through_trains
    @trains.each { |train| yield(train) }
  end

  def add_train(train)
    @trains << train
  end

  def get_trains_by_type
    @trains.reduce({}) do |acc, train|
      acc[train.type] = acc[train.type].nil? ? 1 : acc[train.type] + 1
      acc
    end
  end

  def depart_train(train)
    if (@trains.include?(train))
      @trains.delete(train)
      @trains.compact!
    end
  end
end
