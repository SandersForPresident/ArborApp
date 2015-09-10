class GroupMembership < ActiveRecord::Base
  has_and_belongs_to_many :skills
  belongs_to :group
  belongs_to :user
end
