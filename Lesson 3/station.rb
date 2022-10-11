require_relative "./modules/instance_counter.rb"

class Station
  include InstanceCounter

  @@stations = []
  def self.all
    @@stations
  end

  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
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
      acc[train.type] = acc[train.type].nil? ? 1 : acc[train.type] + 1
      acc
    end
  end

  def depart_train(train)
    if (@trains.include?(train))
      puts "#{@name}: Train #{train.number} has just departed!"
      @trains.delete(train)
      @trains.compact!
    else
      puts "#{@name}: Error, there is no #{train} train at this station!"
    end
  end
end
