class DropGroupMembershipSkills < ActiveRecord::Migration
  def change
    drop_table :group_memberships_skills
  end
end
