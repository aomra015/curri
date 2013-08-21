class Rating < ActiveRecord::Base
  belongs_to :checkpoint
  OPTIONS = ["Rate your understanding", "Don't Understand","Somewhat Comfortable","Totally Understand"]
end
