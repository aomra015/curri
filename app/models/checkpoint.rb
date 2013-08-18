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
end
