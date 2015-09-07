class Team < ActiveRecord::Base
  belongs_to :account
  has_and_belongs_to_many :skills
  has_many :team_users
  has_many :users, through: :team_users
  belongs_to :parent_team, class_name: 'Team', foreign_key: :team_id
  has_many :subteams, class_name: 'Team'
end
