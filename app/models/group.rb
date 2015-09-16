class Group < ActiveRecord::Base
  include Joinable

  belongs_to :parent_group, class_name: 'Group', foreign_key: :group_id
  belongs_to :team

  has_and_belongs_to_many :skills

  has_many :subgroups, class_name: 'Group'

  def admin?(user)
    self_admin?(user) || team_admin?(user) || parent_group_admin?(user) || false
  end

  def member?(user)
    self_member?(user) || team_member?(user) ||
      parent_group_member?(user) || false
  end

  [:admin, :member].each do |membership_type|
    membership_check = "#{membership_type}?".to_sym
    team_membership_check = "team_#{membership_type}?".to_sym
    self_membership_check = "self_#{membership_type}?".to_sym
    parent_group_membership_check = "parent_group_#{membership_type}?".to_sym

    define_method team_membership_check do |user|
      team.send(membership_check, user)
    end
    private team_membership_check.to_sym

    define_method self_membership_check do |user|
      memberships.where(user: user).any?(&membership_check)
    end
    private self_membership_check

    define_method parent_group_membership_check do |user|
      parent_group && parent_group.send(membership_check, user)
    end
    private parent_group_membership_check
  end
end
