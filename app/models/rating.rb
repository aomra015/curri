class Rating < ActiveRecord::Base
  belongs_to :checkpoint
  belongs_to :student

  validates :score, presence: true

  scope :distinct_by_student, -> { select("DISTINCT ON (student_id) * ").order("student_id, created_at DESC") }
  scope :distinct_by_checkpoint, -> { select("DISTINCT ON (checkpoint_id) * ").order("checkpoint_id, created_at DESC") }
  scope :distinct_by_checkpoint_student, -> { select("DISTINCT ON (student_id, checkpoint_id) * ").order("student_id, checkpoint_id, created_at DESC") }

  OPTIONS = ["Don't Understand", "Somewhat Comfortable", "Totally Understand"]
end
