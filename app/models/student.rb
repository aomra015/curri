class Student < ActiveRecord::Base
  has_one :user, as: :classrole, dependent: :destroy
  has_many :invitations
  has_many :classrooms, through: :invitations
  has_many :ratings

  delegate :email, to: :user
end
