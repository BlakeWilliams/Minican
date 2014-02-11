module Minican
  class AccessDenied < StandardError

    # This is raised when a policy fails in a controller via 
    # {Minican::ControllerAdditions}
    #
    # @param [policy] The policy that authorized it
    def initialize(policy)
      @policy = policy
    end

    # Human readable error message
    def to_s
      "You are not authorized to access this page"
    end
  end
end
