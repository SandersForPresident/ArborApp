class RenameGroupMembershipIdToMembershipIdInMembershipSkills < ActiveRecord::Migration
  def change
    rename_column :memberships_skills, :group_membership_id, :membership_id
  end
end
