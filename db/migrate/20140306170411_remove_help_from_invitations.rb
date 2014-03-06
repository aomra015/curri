class RemoveHelpFromInvitations < ActiveRecord::Migration
  def change
    remove_column :invitations, :help, :boolean
  end
end
