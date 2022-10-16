module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, type, param = false)
      @validate ||= []
      @validate << { name: name, type: type, param: param }
    end
  end

  module InstanceMethods
    def valid?
      begin
        validate!
        true
      rescue => exception
        puts exception
        false
      end
    end

    def validate!
      self.class.instance_variable_get(:@validate).each do |validation|
         
        name = validation[:name]
        type = validation[:type]
        param = validation[:param]
        value = instance_variable_get("@#{name}")
        send("validate_#{type}", name, value, param)
      end
    end

    def validate_presence(name, value, _)
      raise "The #{name} should be present" if value.nil? || value.to_s.strip.empty?
    end

    def validate_length(name, value, param)
      raise "The #{name}'s value should be at least #{param} length" if value.length < params
    end

    def validate_format(name, value, regex)
      raise "Wrong format of #{name}'s value" if value !~ regex
    end

    def validate_type(name, value, type)
      raise "Wrong type of #{name}'s value" unless value.is_a?(type)
    end

    def validate_positive(name, value, _)
      raise "The #{name}'s value should be more then 0" if value.negative?
    end
  end
end
