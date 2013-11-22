class AddHelpToStudents < ActiveRecord::Migration
  def change
    add_column :students, :help, :boolean, default: false
  end
end
