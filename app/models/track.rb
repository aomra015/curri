class Track < ActiveRecord::Base
  has_many :checkpoints
end
