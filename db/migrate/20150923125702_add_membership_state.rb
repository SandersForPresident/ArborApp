class AddMembershipState < ActiveRecord::Migration
  def change
    add_column :memberships, :aasm_state, :string
  end
end
