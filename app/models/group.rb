class Group < ActiveRecord::Base
  belongs_to :parent_group, class_name: 'Group', foreign_key: :group_id
  belongs_to :team

  has_and_belongs_to_many :skills

  has_many :subgroups, class_name: 'Group'
  has_many :group_memberships
  has_many :users, through: :group_memberships
end
