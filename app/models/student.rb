class Student < ActiveRecord::Base
  has_one :user, as: :classrole, dependent: :destroy
  has_many :invitations
  has_many :classrooms, through: :invitations

  delegate :username, :email, to: :user
end
