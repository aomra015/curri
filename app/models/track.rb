class Track < ActiveRecord::Base
  belongs_to :classroom
  has_many :checkpoints
  validates :name, presence: true

  def phasing?
    start_date && start_time && end_date && end_time
  end
end
