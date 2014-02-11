module Minican
  module Helpers

    private

    # Returns a new policy for passed in object
    #
    # @param [object] The object to create a policy for
    #
    # @visibility public
    def policy_for(object)
      policy_class(object).new(object)
    end

    # Returns a policy class based on the object
    # passed in. If object is a class, it will 
    # return itself, if it's an instance it will 
    # return a class based on its name.
    #
    # @param [object] The object to classify
    #
    # @visibility public
    def policy_class(object)
      if object.class == Class
        class_name = object
      else
        class_name = object.class
      end

      "#{class_name.to_s}Policy".constantize
    end
  end
end
