require_relative "./modules/instance_counter"
require_relative "./modules/validation"
require_relative "./modules/accessor"

class Station
  include InstanceCounter
  include Validation
  include Accessor

  STATION_NAME = /^\w{2,}(\d+|\w+)$/i.freeze


  @@stations = []
  def self.all
    @@stations
  end

  attr_reader :name, :trains

  validate :name, :format, STATION_NAME

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
    register_instance
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
    return unless @trains.include?(train)

    @trains.delete(train)
    @trains.compact!
  end
end
