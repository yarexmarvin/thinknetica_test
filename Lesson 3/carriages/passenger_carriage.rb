require_relative "carriage.rb"

class PassengerCarriage < Carriage
  attr_reader :seats, :taken_seats

  def initialize(name, type, seats)
    super(name, type)
    @seats = seats
    @taken_seats = 0
  end

  def take_a_seat
    if (@taken_seats < @seats)
      @taken_seats += 1
    end
  end

  def free_seats
    @seats - @taken_seats
  end
  
end
