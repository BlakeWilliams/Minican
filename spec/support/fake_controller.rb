class FakeController
  def current_user
    FakeUser.new
  end

  def self.helper_method(method)
    #noop
  end

  include Minican::ControllerAdditions
end
