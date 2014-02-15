class Invitation < ActiveRecord::Base
  belongs_to :classroom, :counter_cache => :students_count
  belongs_to :student

  before_create :generate_token
  validates :email, :email => true

  scope :help_needed, -> { where(help: true).order(" updated_at ASC") }
  scope :pending, -> { where(student_id: nil) }
  scope :accepted, -> { where.not(student_id: nil) }

  delegate :full_name, to: :student, allow_nil: true
  delegate :gravatar, to: :student

  def status
    student ? 'Accepted' : 'Pending'
  end

  def email_address
    student ? student.email : email
  end

  private
  def generate_token
    begin
      self.token = SecureRandom.urlsafe_base64
    end while Invitation.exists?(token: self.token)
  end
end
