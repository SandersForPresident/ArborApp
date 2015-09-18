class MoveSlackInfoFromUserToMembership < ActiveRecord::Migration
  def change
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :slack_access_token

    add_column :memberships, :slack_uid, :string
    add_column :memberships, :slack_access_token, :string
  end
end
