class TeamUser < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  belongs_to :skill
end
