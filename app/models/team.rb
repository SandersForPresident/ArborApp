class Team < ActiveRecord::Base
  include Joinable

  def admin?(user)
    memberships.where(user: user).any?(&:admin?)
  end

  def member?(user)
    memberships.where(user: user).any?(&:member?)
  end
end
