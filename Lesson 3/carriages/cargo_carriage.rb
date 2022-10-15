require_relative 'carriage'

class CargoCarriage < Carriage
  def fill_volume(volume)
    result = @filled_volume + volume <= @volume
    @filled_volume += volume if result
  end
end
