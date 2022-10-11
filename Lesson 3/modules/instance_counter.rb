module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      instance_counter = self.class_variable_get(:@@instance_counter)
      if (instance_counter.nil? || instance_counter.zero?)
        puts '----------------------'
        puts "There is no instances"
        puts '----------------------'

      else
        puts '#####################################'
        puts "#{self.name}s: #{instance_counter}"
        puts '#####################################'
      end
    end
  end

  module InstanceMethods
    def register_instance
      if (!self.class.class_variable_defined?(:@@instance_counter))
        self.class.class_variable_set(:@@instance_counter, 0)
      end
      instance_counter = self.class.class_variable_get(:@@instance_counter)
      instance_counter += 1
      self.class.class_variable_set(:@@instance_counter, instance_counter)
    end
  end
end
