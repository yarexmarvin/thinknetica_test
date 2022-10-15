require_relative 'carriage'

class PassengerCarriage < Carriage
  def fill_volume
    @filled_volume += 1 if @filled_volume < @volume
  end
end
