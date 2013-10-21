class Classroom < ActiveRecord::Base
  has_many :tracks

  has_many :invitations
  has_many :students, through: :invitations

  belongs_to :teacher
  validates :name, presence: true


  def students_list
    s_list = []
    self.students.each do |student|
      s_list << student.id
    end
    s_list
  end

end
