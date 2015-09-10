class DropTeamUsers < ActiveRecord::Migration
  def change
    drop_table :team_users
  end
end
