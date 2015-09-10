class RemoveAccountIdFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :account_id
  end
end
