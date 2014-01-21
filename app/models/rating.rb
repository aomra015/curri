class Rating < ActiveRecord::Base
  belongs_to :checkpoint
  belongs_to :student

  scope :latest_distinct, -> { select("DISTINCT ON (student_id) * ").order("student_id, created_at DESC") }
  OPTIONS = ["Don't Understand", "Somewhat Comfortable", "Totally Understand"]
end
