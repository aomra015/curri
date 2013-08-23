class Student < ActiveRecord::Base
  has_one :user, as: :classrole, dependent: :destroy

  delegate :username, :email, to: :user
end
