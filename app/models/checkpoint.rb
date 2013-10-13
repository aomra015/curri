class Checkpoint < ActiveRecord::Base
  belongs_to :track
  has_many :ratings

  validates  :expectation, :success_criteria, presence: true

  def ratings_count(start_time, end_time, score="all")
    if self.ratings.any?
      ratings_over_time = self.ratings.where({ created_at: start_time..end_time }).group(:student_id)
      if score == "all"
        ratings_over_time.length
      else
        ratings_over_time.where(score: score).length
      end
    else
      0
    end
  end

  def get_score(score, start_time, end_time)
    if self.ratings.any?
      ratings_count(start_time, end_time, score) * 100.0 / ratings_count(start_time, end_time)
    else
      0
    end
  end

end
