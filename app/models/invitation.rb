class Invitation < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :student

  before_create :generate_token
  validates :email, format: { with: /\A[^@]+@[^@]+\z/ }

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
