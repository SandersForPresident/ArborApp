class Group < ActiveRecord::Base
  belongs_to :account
  has_and_belongs_to_many :skills
  has_many :users, through: :group_memberships
  belongs_to :parent_group, class_name: 'Group', foreign_key: :group_id
  has_many :subgroups, class_name: 'Group'
end
