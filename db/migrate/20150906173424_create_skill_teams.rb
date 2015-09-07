class CreateSkillTeams < ActiveRecord::Migration
  def change
    create_table :skill_teams do |t|
      t.belongs_to :skill
      t.belongs_to :team
    end
  end
end
