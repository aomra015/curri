class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :classroom, index: true
      t.references :student, index: true
      t.string :token

      t.timestamps
    end
  end
end
