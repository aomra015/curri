class Checkpoint < ActiveRecord::Base
  belongs_to :track
  has_many :ratings
end
