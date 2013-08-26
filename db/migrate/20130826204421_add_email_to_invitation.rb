class AddEmailToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :email, :string
  end
end
