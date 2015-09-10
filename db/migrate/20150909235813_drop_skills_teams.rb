class DropSkillsTeams < ActiveRecord::Migration
  def change
    drop_table :skills_teams
  end
end
