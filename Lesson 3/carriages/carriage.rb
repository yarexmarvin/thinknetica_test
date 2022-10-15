require_relative '../modules/manufacture'
require_relative '../modules/validation'

class Carriage
  include Manufacture
  include Validation

  attr_reader :name, :type, :volume, :filled_volume

  def initialize(name, type, volume)
    @name = name
    @type = type
    @volume = volume
    @filled_volume = 0
    validate('carriage', 'name', name)
  end

  def valid?
    validate('carriage', 'name', name)
    true
  rescue StandardError
    false
  end

  def free_volume
    @volume - @filled_volume
  end

  def fill_volume; end
end
