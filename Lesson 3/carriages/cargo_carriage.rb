require_relative "carriage.rb"

class CargoCarriage < Carriage
  def fill_volume(volume)
    result = @filled_volume + volume <= @volume
    if (result)
      @filled_volume += volume
    end
  end
end
