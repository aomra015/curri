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

  def zero_score
    if self.ratings.any?
      self.ratings.where(score: 0).count * 100.0 / self.ratings.size
    else
      0
    end
  end

  def one_score
    if self.ratings.any?
      self.ratings.where(score: 1).count * 100.0 / self.ratings.size
    else
      0
    end
  end

  def two_score
    if self.ratings.any?
      self.ratings.where(score: 2).count * 100.0 / self.ratings.size
    else
      0
    end
  end
end
