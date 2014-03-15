class Classroom < ActiveRecord::Base
  has_many :tracks

  has_many :invitations
  has_many :requesters
  has_many :students, through: :invitations

  has_many :classroom_teachers
  has_many :teachers, through: :classroom_teachers
  validates :name, presence: {message: "You must name the classroom!"}
  validates_length_of :name, :maximum => 90
  validates_length_of :description, :maximum => 90, :allow_blank => true

  default_scope { order(id: :asc) }
  before_create :generate_token

  private
  def generate_token
    begin
      self.teacher_token = SecureRandom.urlsafe_base64(6)
    end while Classroom.exists?(teacher_token: self.teacher_token)
  end

end
