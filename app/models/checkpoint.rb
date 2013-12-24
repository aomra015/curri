class Checkpoint < ActiveRecord::Base
  belongs_to :track
  has_many :ratings

  validates  :expectation, :success_criteria, presence: true

  default_scope { order(id: :asc) }

  def hasnt_voted(phase)
    hasnt_voted_list = []
    scoped_ratings = phase.ratings(self) if self.ratings.any?

    if self.ratings.empty? || scoped_ratings.empty?
      hasnt_voted_list << "all"

    elsif  self.track.classroom.students.count != scoped_ratings.length
      student_list = self.track.classroom.students.pluck(:id)
      scoped_ratings.each do |rating|
        student_list.delete(rating.student.id)
      end
      student_list.each do |student_id|
        hasnt_voted_list << Student.find(student_id).email
      end
    end

    hasnt_voted_list
  end

  def latest_student_score(student)
    ratings.where(student_id: student.id).last.try(:score).to_s
  end

end
