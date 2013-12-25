class Student < ActiveRecord::Base
  has_one :user, as: :classrole, dependent: :destroy
  has_many :invitations
  has_many :classrooms, through: :invitations
  has_many :ratings

  delegate :email, to: :user
  delegate :first_name, to: :user
  delegate :last_name, to: :user

  def track_ratings(track)
    self.ratings.where({ checkpoint_id: track.checkpoints.pluck(:id) }).select("DISTINCT ON (checkpoint_id) * ").order("checkpoint_id, created_at DESC")
  end

end
