class AddStudentsCountToClassroom < ActiveRecord::Migration
  def self.up
    add_column :classrooms, :students_count, :integer, :default => 0
    Classroom.reset_column_information
    Classroom.all.each do |c|
        Classroom.reset_counters(c.id, :students)
    end
  end

  def self.down
    remove_column :classrooms, :students_count
  end
end