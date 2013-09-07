class AddStudentToRating < ActiveRecord::Migration
  def change
    add_reference :ratings, :student, index: true
  end
end
