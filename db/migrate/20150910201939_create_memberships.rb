class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :joinable, polymorphic: true
      t.belongs_to :user
      t.integer :role, default: 0

      t.timestamps null: false
    end
  end
end
