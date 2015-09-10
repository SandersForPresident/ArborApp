class CreateGroupMembershipsSkills < ActiveRecord::Migration
  def change
    create_table :group_memberships_skills do |t|
      t.belongs_to :group_membership
      t.belongs_to :skill
    end
  end
end
