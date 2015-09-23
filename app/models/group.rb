class Group < ActiveRecord::Base
  include Joinable

  belongs_to :parent_group, class_name: 'Group', foreign_key: :group_id
  belongs_to :team

  has_and_belongs_to_many :skills

  has_many :subgroups, class_name: 'Group'

  [:admin, :member].each do |membership_type|
    has_membership = "#{membership_type}?".to_sym
    has_team_membership = "team_#{membership_type}?".to_sym
    has_self_membership = "self_#{membership_type}?".to_sym
    has_parent_group_membership = "parent_group_#{membership_type}?".to_sym

    define_method has_membership do |user|
      send(has_self_membership, user) ||
        send(has_team_membership, user) ||
        send(has_parent_group_membership, user) ||
        false
    end

    define_method has_team_membership do |user|
      team.send(has_membership, user)
    end
    private has_team_membership

    define_method has_self_membership do |user|
      memberships.where(user: user).any? do |membership|
        membership.send(has_membership) && membership.approved?
      end
    end
    private has_self_membership

    define_method has_parent_group_membership do |user|
      parent_group && parent_group.send(has_membership, user)
    end
    private has_parent_group_membership
  end
end
