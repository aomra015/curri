class Checkpoint < ActiveRecord::Base
  belongs_to :track
  has_many :ratings

  validates  :expectation, :success_criteria, presence: true

  def ratings_count(start_time, end_time, score="all")
    if self.ratings.any?
      scoped_ratings = self.ratings.where({ created_at: start_time..end_time }).group(:student_id)
      if score == "all"
        scoped_ratings.length
      else
        get_score_count(score, scoped_ratings)
      end
    else
      0
    end
  end

  def get_score_count(score, ratings)
    count = 0
    ratings.each do |rating|
      count += 1 if rating.score == score
    end
    count
  end

  def get_score(score, start_time, end_time)
    if self.ratings.any?
      ratings_count(start_time, end_time, score) * 100.0 / ratings_count(start_time, end_time)
    else
      0
    end
  end

end
