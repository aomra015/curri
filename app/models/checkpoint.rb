class Checkpoint < ActiveRecord::Base
  belongs_to :track
  acts_as_list scope: :track
  has_many :ratings

  validates :expectation, :success_criteria, presence: true
  validates_length_of :expectation, :maximum => 50
  validates_length_of :success_criteria, :maximum => 300

  def latest_student_score(student)
    ratings.where(student_id: student.id).last.try(:score)
  end

  def hasnt_voted(phase, classroom)
    scoped_ratings = phase.ratings(self)
    numb_ratings = scoped_ratings.length
    numb_students = classroom.students.count

    if (numb_ratings >= (numb_students*0.75).floor) && (numb_ratings < numb_students)
      student_list = classroom.students.pluck(:id)
      scoped_ratings.includes(:student).each do |rating|
        student_list.delete(rating.student.id)
      end
      student_list.map { |id| Student.find(id).full_name }
    end
  end

end
