class Group < ActiveRecord::Base
  belongs_to :parent_group, class_name: 'Group', foreign_key: :group_id
  belongs_to :team

  has_and_belongs_to_many :skills

  has_many :subgroups, class_name: 'Group'
  has_many :memberships, as: :joinable
  has_many :users, through: :memberships

  def admin?(user)
    self_admin?(user) || team_admin?(user) || parent_group_admin?(user) || false
  end

  def member?(user)
    memberships.where(user: user).any?(&:member?)
  end

  def contains?(user)
    admin?(user) || member?(user)
  end

  private

  def team_admin?(user)
    team.admin? user
  end

  def self_admin?(user)
    memberships.where(user: user).any?(&:admin?)
  end

  def parent_group_admin?(user)
    parent_group && parent_group.admin?(user)
  end
end
