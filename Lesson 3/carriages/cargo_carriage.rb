require_relative "carriage.rb"

class CargoCarriage < Carriage
  attr_reader :capacity, :filled_capacity

  def initialize(name, type, capacity)
    super(name, type)
    @capacity = capacity
    @filled_capacity = 0
  end

  def fill_capacity(capacity)
    result = @filled_capacity + capacity <= @capacity
    if (result)
      @filled_capacity += capacity
    end
  end

  def free_capacity
    @capacity - @filled_capacity
  end
end
