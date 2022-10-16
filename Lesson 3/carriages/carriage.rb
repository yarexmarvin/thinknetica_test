require_relative '../modules/manufacture'
require_relative "../modules/validation"
require_relative "../modules/accessor"


class Carriage
  include Manufacture
  include Validation
  include Accessor


  CARRIAGE_NAME = /^\w+(\d+|\w+)$/i.freeze

  validate :name, :format, CARRIAGE_NAME
  validate :volume, :presence
  validate :type, :presence
  validate :volume, :positive

  attr_reader :name, :type, :volume, :filled_volume

  def initialize(name, type, volume)
    @name = name
    @type = type
    @volume = volume
    @filled_volume = 0
    validate!
  end

  def free_volume
    @volume - @filled_volume
  end

  def fill_volume; end
end
