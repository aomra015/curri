class Classroom < ActiveRecord::Base
  has_many :tracks

  has_many :invitations
  has_many :students, through: :invitations

  belongs_to :teacher
  validates :name, presence: true

  default_scope { order(id: :asc) }

  def requesters_count
    if self.students.any?
      requesters = get_requesters || []
      requesters.length
    else
      0
    end
  end
  def get_requesters
    self.students.where({ help: true }).order(" updated_at ASC")
    #for now getting time data of help request from update of student model should do since no other attribs to update in student
  end

end
