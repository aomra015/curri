class Checkpoint < ActiveRecord::Base
  belongs_to :track
  has_many :ratings

  validates  :expectation, :success_criteria, presence: true

  default_scope { order(id: :asc) }

  def latest_student_score(student)
    ratings.where(student_id: student.id).last.try(:score).to_s
  end

end
