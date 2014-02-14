module Minican
  module ControllerAdditions
    include Minican::Helpers

    private

    # Controller helper method to verify call method on
    # policy. Raises {Minican::AccessDenied} if the policy
    # method fails
    #
    # @param method [Symbol] method to be called on the policy
    # @param object [Object] The object to apply the policy to
    # @param user [User] The user object to pass to the method
    #
    # @visibility public
    def authorize!(method, object, user = current_user)
      policy = policy_for(object)

      if policy.cannot?(method, current_user)
        raise Minican::AccessDenied.new(policy)
      end
    end

    # Controller helper method to filter out non-authorized
    # objects from the passed in array
    #
    # @param method [Symbol] method to be called on each policy
    # @param objects [Array] array of objects to filter
    # @param user [User] The current user object to pass
    # @return (Array)
    #
    # @visibility public
    def filter_authorized!(method, objects, user = current_user)
      object_array = Array(objects)

      object_array.select do |object|
        policy = policy_for(object)
        policy.can?(method, user)
      end
    end

    # Helper method available in controllers and views
    # that returns the value of the policy method
    #
    # @param (see #authorize!)
    # @return (Boolean)
    #
    # @visibility public
    def can?(method, object, user = current_user)
      policy = policy_for(object)
      policy.can?(method, user)
    end

    # Helper method available in controllers and views
    # that returns the negated value of the policy method
    #
    # @param (see #can?)
    # @return (see #can?)
    #
    # @visibility public
    def cannot?(method, object, user = current_user)
      !can?(method, object, user)
    end

    def self.included(base)
      base.helper_method :can?
      base.helper_method :cannot?
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Minican::ControllerAdditions
  end
end
