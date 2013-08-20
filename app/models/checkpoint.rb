class Checkpoint < ActiveRecord::Base
  belongs_to :track
  has_many :ratings


  def options
    ["Rate your understanding", "Don't Understand","Feel Comfortable","Totally Understand"]
  end

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

  def zero_score(start_time, end_time)
    if self.ratings.any?
      self.ratings.where({ created_at: start_time..end_time }).where(score: 0).count * 100.0 / self.ratings.size
    else
      0
    end
  end

  def one_score(start_time, end_time)
    if self.ratings.any?
      self.ratings.where({ created_at: start_time..end_time }).where(score: 1).count * 100.0 / self.ratings.size
    else
      0
    end
  end

  def two_score(start_time, end_time)
    if self.ratings.any?
      self.ratings.where({ created_at: start_time..end_time }).where(score: 2).count * 100.0 / self.ratings.size
    else
      0
    end
  end
end
