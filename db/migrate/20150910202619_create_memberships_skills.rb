class CreateMembershipsSkills < ActiveRecord::Migration
  def change
    create_table :memberships_skills do |t|
      t.belongs_to :group_membership
      t.belongs_to :skill
    end
  end
end
