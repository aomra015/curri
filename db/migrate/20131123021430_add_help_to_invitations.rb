class AddHelpToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :help, :boolean, default: false
  end
end
