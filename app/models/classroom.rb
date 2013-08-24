class Classroom < ActiveRecord::Base
  has_many :tracks
  belongs_to :teacher
end
