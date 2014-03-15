class Requester < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :student

  scope :need_help, -> { where(help: true).order(" updated_at ASC") }

  delegate :full_name, to: :student
  delegate :gravatar, to: :student
end
