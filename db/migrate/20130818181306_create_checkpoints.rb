class CreateCheckpoints < ActiveRecord::Migration
  def change
    create_table :checkpoints do |t|
      t.string :content
      t.references :track, index: true

      t.timestamps
    end
  end
end
