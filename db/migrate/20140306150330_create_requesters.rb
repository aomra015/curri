class CreateRequesters < ActiveRecord::Migration
  def change
    create_table :requesters do |t|
      t.boolean :help
      t.references :classroom, index: true
      t.references :student, index: true
      t.timestamps
    end
  end
end
