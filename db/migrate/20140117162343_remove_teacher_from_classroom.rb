class RemoveTeacherFromClassroom < ActiveRecord::Migration
  def change
    remove_column :classrooms, :teacher_id
  end
end
