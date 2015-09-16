class AddSlackTeamIdAndDomainToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :slack_team_id, :string, null: false
    add_column :teams, :slack_team_domain, :string, null: false
  end
end
