class Track < ActiveRecord::Base
  belongs_to :classroom
  has_many :checkpoints
end
