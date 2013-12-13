class AddMissingDbIndex < ActiveRecord::Migration
  def change
    add_index :classrooms, :teacher_id
  end
end
