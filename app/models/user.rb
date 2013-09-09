class User < ActiveRecord::Base
  belongs_to :classrole, polymorphic: true
  validates  :email, presence: true
  validates :email, uniqueness: true

  has_secure_password

  delegate :classrooms, to: :classrole

  def teacher?
    classrole_type == 'Teacher'
  end

  def student?
    classrole_type == 'Student'
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
