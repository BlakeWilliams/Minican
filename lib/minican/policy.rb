module Minican
  class Policy
    include Minican::Helpers

    # Creates a new instance of policy with object
    # that is accessible via {object} or after the
    # name of the policy class
    #
    # @param [object] The object the policy tests against
    def initialize(object)
      instance_variable_set(instance_name, object)
    end

    # Convenience method to call predicate method
    # and return the value
    #
    # @param [method] Method to call
    # @param [user] User to send to the method
    #
    # @return [Boolean]
    def can?(method, user)
      send("#{method}?", user)
    end

    # Convenience method to call predicate method
    # and return the negated value
    #
    # @param [method] Method to call
    # @param [user] User to send to the method
    #
    # @return [Boolean]
    def cannot?(method, user)
      !can?(method, user)
    end

    # Conveneince method to get the current object
    # without having to get the class name
    def object
      instance_variable_get(instance_name)
    end

    private

    def instance_name
      class_name = self.class.to_s.gsub(/Policy$/, '')
      "@#{class_name.underscore}"
    end
  end
end
