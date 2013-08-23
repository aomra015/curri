class User < ActiveRecord::Base
  belongs_to :classrole, polymorphic: true

  has_secure_password
end
