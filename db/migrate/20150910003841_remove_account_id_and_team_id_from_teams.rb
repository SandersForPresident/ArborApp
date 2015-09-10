class RemoveAccountIdAndTeamIdFromTeams < ActiveRecord::Migration
  def change
    remove_foreign_key :teams, :accounts
    remove_foreign_key :teams, :teams
  end
end
