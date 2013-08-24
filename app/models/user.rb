class User < ActiveRecord::Base
  belongs_to :classrole, polymorphic: true

  has_secure_password

  delegate :classrooms, to: :classrole
end
