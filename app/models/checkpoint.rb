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

  def ratings_count(start_time, end_time)
    if self.ratings.any?
      self.ratings.where({ created_at: start_time..end_time }).count
    else
      0
    end
  end

  def get_score(score, start_time, end_time)
    if self.ratings.any?
      ratings_over_time = self.ratings.where({ created_at: start_time..end_time })
      ratings_over_time.where(score: score).count * 100.0 / ratings_over_time.count
    else
      0
    end
  end

end
