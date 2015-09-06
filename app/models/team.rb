class Team < ActiveRecord::Base
  has_and_belongs_to_many :skills
  has_many :team_users
  has_many :users, through: :team_users
end
