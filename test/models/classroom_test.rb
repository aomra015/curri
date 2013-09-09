require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase
  test "validates presence of name" do
    skip
    classroom = Classroom.new
    classroom.valid?
    assert classroom.errors[:name].any?
  end
end
