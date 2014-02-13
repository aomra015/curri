class Track < ActiveRecord::Base
  belongs_to :classroom, :counter_cache => true
  has_many :checkpoints, -> { order("position ASC") }
  validates :name, presence: true

  acts_as_list
  default_scope { order(position: :asc) }
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  def phasing?
    start_time && end_time
  end

  def ratings
    Rating.where({ checkpoint_id: checkpoints.pluck(:id) }).distinct_by_checkpoint_student
  end
end
