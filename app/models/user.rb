class User < ActiveRecord::Base
  has_many :groups, through: :group_memberships
  has_many :teams, through: :team_memberships

  validates :slack_access_token, presence: true
  validates :email, presence: true
  validates :name, presence: true
  validates :uid, presence: true, uniqueness: { scope: [:provider] }
end
