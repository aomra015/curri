class AddTeacherTokenToClassroom < ActiveRecord::Migration
  def change
    add_column :classrooms, :teacher_token, :string
  end
end
