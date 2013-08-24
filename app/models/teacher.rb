class Teacher < ActiveRecord::Base
  has_one :user, as: :classrole, dependent: :destroy
  has_many :classrooms

  delegate :username, :email, to: :user
end
