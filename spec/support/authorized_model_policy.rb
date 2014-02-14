class AuthorizedModelPolicy < Minican::Policy
  def read?(user)
    true
  end
end
