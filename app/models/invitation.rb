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
    student ? student.email : email
  end

  def full_name
    "#{student.first_name} #{student.last_name}" if student
  end
end
