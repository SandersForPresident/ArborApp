class User < ActiveRecord::Base
  has_many :memberships
  has_many :teams,
           through: :memberships,
           source: :joinable,
           source_type: 'Team'
  has_many :groups,
           through: :memberships,
           source: :joinable,
           source_type: 'Group'

  validates :email, presence: true, uniqueness: true
end
