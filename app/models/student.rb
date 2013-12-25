class Student < ActiveRecord::Base
  has_one :user, as: :classrole, dependent: :destroy
  has_many :invitations
  has_many :classrooms, through: :invitations
  has_many :ratings

  delegate :email, to: :user
  delegate :first_name, to: :user
  delegate :last_name, to: :user

  def student_ratings_count(track, score)
    if self.ratings.any?
      track_ratings = track_ratings(track)
      if score == "empty"
        track.checkpoints.length - track_ratings.length
      else
        get_student_score_count(score, track_ratings)
      end
    else
      0
    end
  end
  def track_ratings(track)
    self.ratings.where({ checkpoint_id: track.checkpoints.pluck(:id) }).select("DISTINCT ON (checkpoint_id) * ").order("checkpoint_id, created_at DESC")
  end

  def get_student_score_count(score, ratings)
    count = 0
    ratings.each do |rating|
      count += 1 if rating.score == score
    end
    count
  end
end
