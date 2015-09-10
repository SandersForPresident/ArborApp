class CreateGroupsSkills < ActiveRecord::Migration
  def change
    create_table :groups_skills do |t|
      t.belongs_to :group
      t.belongs_to :skill
    end
  end
end
