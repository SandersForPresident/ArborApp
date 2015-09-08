class CreateSkillsTeams < ActiveRecord::Migration
  def change
    create_table :skills_teams do |t|
      t.belongs_to :skill
      t.belongs_to :team
    end
  end
end
