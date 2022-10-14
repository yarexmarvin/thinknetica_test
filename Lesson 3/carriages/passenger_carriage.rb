require_relative "carriage.rb"

class PassengerCarriage < Carriage
  def fill_volume
    if (@filled_volume < @volume)
      @filled_volume += 1
    end
  end
end
