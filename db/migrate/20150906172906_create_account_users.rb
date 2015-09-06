class CreateAccountUsers < ActiveRecord::Migration
  def change
    create_table :account_users do |t|
      t.belongs_to :account
      t.belongs_to :user
      t.integer :role, default: 0

      t.timestamps null: false
    end
  end
end
