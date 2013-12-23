class Invitation < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :student

  before_create :generate_token
  validates :email, :email => true

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def status
    student ? 'Accepted' : 'Pending'
  end

  def email_address
    if self.student_id
      self.student.email
    else
      self.email
    end
  end

  def full_name
    self.student.first_name + " " + self.student.last_name if self.student_id
  end
end
