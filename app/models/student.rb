class Student < ActiveRecord::Base
  has_one :user, as: :classrole, dependent: :destroy
  has_many :invitations
  has_many :classrooms, through: :invitations
  has_many :ratings

  delegate :email, to: :user

  def student_ratings_count(track, score="all")
    if self.ratings.any?
      track_ratings = get_track_ratings(track)
      if score == "all"
        track_ratings.length
      else
        get_student_score_count(score, track_ratings)
      end
    else
      0
    end
  end
  def get_track_ratings(track)
    self.ratings.where({ checkpoint_id: track.checkpoints }).group(:checkpoint_id)
  end

  def get_student_score_count(score, ratings)
    count = 0
    ratings.each do |rating|
      count += 1 if rating.score == score
    end
    count
  end

  def get_student_unanswered(track)
      track.checkpoints.length - student_ratings_count(track)
  end
end
