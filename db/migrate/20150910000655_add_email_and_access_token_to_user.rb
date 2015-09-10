class AddEmailAndAccessTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string, null: true
    add_column :users, :slack_access_token, :string, null: true
    change_column_null :users, :email, false
  end
end
