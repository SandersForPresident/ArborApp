class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.belongs_to :account
      t.belongs_to :team
      t.belongs_to :group

      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
