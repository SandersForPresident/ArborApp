class Group < ActiveRecord::Base
  include Joinable

  belongs_to :team
  belongs_to :parent_group, class_name: 'Group', foreign_key: :group_id
  has_many :subgroups, class_name: 'Group'
  has_and_belongs_to_many :skills

  def admin?(user)
    team.admin?(user) ||
      memberships.where(user: user).any? { |m| m.admin? && m.approved? } ||
      parent_group.present? && parent_group.admin?(user)
  end

  def member?(user)
    team.member?(user) ||
      memberships.where(user: user).any? { |m| m.member? && m.approved? } ||
      parent_group.present? && parent_group.member?(user)
  end
end
