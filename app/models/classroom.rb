class Classroom < ActiveRecord::Base
  has_many :tracks

  has_many :invitations
  has_many :students, through: :invitations

  belongs_to :teacher
end
