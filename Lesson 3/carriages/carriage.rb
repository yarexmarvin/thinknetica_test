require_relative "../modules/manufacture.rb"
require_relative "../modules/validation.rb"

class Carriage

    include Manufacture
    include Validation

    attr_reader :name, :type
    def initialize(name, type)
        @name = name
        @type = type
        validate('carriage', 'name', name)
    end
end
