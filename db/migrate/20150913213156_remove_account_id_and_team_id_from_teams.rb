class RemoveAccountIdAndTeamIdFromTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :account_id
    remove_column :teams, :team_id
  end
end
