class User < ActiveRecord::Base
  belongs_to :classrole, polymorphic: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, :email => true
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_secure_password

  delegate :classrooms, to: :classrole
  delegate :needs_help?, to: :classrole

  before_create { generate_token(:auth_token) }
  before_save :set_gravatar

  def teacher?
    classrole_type == 'Teacher'
  end

  def student?
    classrole_type == 'Student'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save
    UserMailer.delay.password_reset(id)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def set_gravatar
    email_address = self.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    self.gravatar = "http://www.gravatar.com/avatar/#{hash}"
  end
end
