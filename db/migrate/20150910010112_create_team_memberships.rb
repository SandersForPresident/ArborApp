class CreateTeamMemberships < ActiveRecord::Migration
  def change
    create_table :team_memberships do |t|
      t.belongs_to :team
      t.belongs_to :user
      t.integer :role, default: 0

      t.timestamps null: false
    end
  end
end
