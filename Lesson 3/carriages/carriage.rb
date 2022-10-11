require_relative "../modules/manufacture.rb"

class Carriage

    include Manufacture
    
    attr_reader :name, :type
    def initialize(name, type)
        @name = name
        @type = type
    end
end
