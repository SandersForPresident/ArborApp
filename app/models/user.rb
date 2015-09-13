class User < ActiveRecord::Base
  has_many :memberships
  has_many :teams, through: :memberships, source: :joinable, source_type: 'Team'
  has_many :groups,
           through: :memberships,
           source: :joinable,
           source_type: 'Group'

  validates :slack_access_token, presence: true
  validates :email, presence: true
  validates :uid, presence: true, uniqueness: { scope: [:provider] }
end
