class Team < ActiveRecord::Base
  has_many :memberships, as: :joinable
  has_many :teams
  has_many :users, through: :memberships

  def admin?(user)
    memberships.where(user: user).any?(&:admin?)
  end

  def member?(user)
    memberships.where(user: user).any?(&:member?)
  end
end
