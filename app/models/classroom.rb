class Classroom < ActiveRecord::Base
  has_many :tracks

  has_many :invitations
  has_many :students, through: :invitations

  has_many :classroom_teachers
  has_many :teachers, through: :classroom_teachers
  validates :name, presence: true

  default_scope { order(id: :asc) }

  def requesters
    invitations.help_needed
  end

end
