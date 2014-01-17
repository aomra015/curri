class Classroom < ActiveRecord::Base
  has_many :tracks

  has_many :invitations
  has_many :students, through: :invitations

  belongs_to :teacher
  validates :name, presence: true
  validates_length_of :description, :maximum => 65, :allow_blank => true

  default_scope { order(id: :asc) }

  def requesters
    invitations.help_needed
  end

end
