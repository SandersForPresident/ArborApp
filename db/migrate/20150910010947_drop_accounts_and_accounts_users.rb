class DropAccountsAndAccountsUsers < ActiveRecord::Migration
  def change
    drop_table :accounts
    drop_table :accounts_users
  end
end
