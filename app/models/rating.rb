class Rating < ActiveRecord::Base
  belongs_to :checkpoint
  belongs_to :student

  OPTIONS = { "Rate your understanding" => :label, "Don't Understand" => 0, "Somewhat Comfortable" => 1, "Totally Understand" => 2 }
end
