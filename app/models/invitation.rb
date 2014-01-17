class Invitation < ActiveRecord::Base
  belongs_to :classroom, :counter_cache => :students_count
  belongs_to :student

  before_create :generate_token
  validates :email, :email => true

  scope :help_needed, -> { where(help: true).order(" updated_at ASC") }
  scope :pending, -> { where(student_id: nil) }
  scope :accepted, -> { where.not(student_id: nil) }

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def status
    student ? 'Accepted' : 'Pending'
  end

  def email_address
    student ? student.email : email
  end

  def full_name
    "#{student.first_name} #{student.last_name}" if student
  end
end
