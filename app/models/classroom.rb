class Classroom < ActiveRecord::Base
  has_many :tracks

  has_many :invitations
  has_many :students, through: :invitations

  has_many :classroom_teachers
  has_many :teachers, through: :classroom_teachers
  validates :name, presence: true
  validates_length_of :description, :maximum => 65, :allow_blank => true

  default_scope { order(id: :asc) }
  before_create :generate_token

  def requesters
    invitations.help_needed
  end

  def generate_token
    begin
      self.teacher_token = SecureRandom.urlsafe_base64(6)
    end while Classroom.exists?(teacher_token: self.teacher_token)
  end

end
