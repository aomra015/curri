class Rating < ActiveRecord::Base
  belongs_to :checkpoint
  belongs_to :student

  OPTIONS = ["Don't Understand", "Somewhat Comfortable", "Totally Understand"]
end
