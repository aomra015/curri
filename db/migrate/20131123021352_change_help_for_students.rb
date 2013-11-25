class ChangeHelpForStudents < ActiveRecord::Migration
  def change
    remove_column :students, :help
  end
end
