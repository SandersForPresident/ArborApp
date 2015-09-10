class Team < ActiveRecord::Base
  has_many :memberships, as: :joinable
  has_many :teams
  has_many :users, through: :memberships
end
