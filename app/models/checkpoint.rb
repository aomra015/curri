class Checkpoint < ActiveRecord::Base
  belongs_to :track
  has_many :ratings

  def overall_score
    if self.ratings.any?
      self.ratings.sum(:score) * 50 / self.ratings.size
    else
      0
    end
  end

  def ratings_count(start_time, end_time, score="all")
    if self.ratings.any?
      ratings_over_time = self.ratings.where({ created_at: start_time..end_time })
      if score == "all"
        ratings_over_time.count
      else
        ratings_over_time.where(score: score).count
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
