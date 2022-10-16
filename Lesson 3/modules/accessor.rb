module Accessor
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym

        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value|
          var_history = "@#{name}_history"

          instance_variable_set(var_history, []) unless (instance_variable_defined?(var_history))

          current_value = instance_variable_get(var_name)
          instance_variable_get(var_history) << current_value
          instance_variable_set(var_name, value)
        end

        define_method("#{name}_history".to_sym) { instance_variable_get("@#{name}_history") }
      end
    end

    def strong_attr_accessor(name, name_class)
      var_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        begin
          raise TypeError.new("Invalid type!") unless value.is_a?(name_class)
          instance_variable_set(var_name, value)
        rescue TypeError => e
          puts "Error #{e.message}"
        end
      end
    end
  end
end
