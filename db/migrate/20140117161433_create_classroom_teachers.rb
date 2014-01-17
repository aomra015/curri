class CreateClassroomTeachers < ActiveRecord::Migration
  def change
    create_table :classroom_teachers do |t|
      t.references :classroom, index: true
      t.references :teacher, index: true

      t.timestamps
    end
  end
end
