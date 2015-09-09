class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.belongs_to :account
      t.belongs_to :team

      t.string :name
      t.text :description
      
      t.timestamps null: false
    end
  end
end
