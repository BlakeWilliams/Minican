class UnauthorizedModelPolicy < Minican::Policy
  def read?(user)
    false
  end
end
