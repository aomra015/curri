class AddIndexToInvitations < ActiveRecord::Migration
  def change
    add_index :invitations, :token
  end
end
