require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "add default classroom" do
    teacher = users(:ahmed)

    teacher.add_default_classroom
    default_classroom = teacher.classrooms.find_by(name: "Curry Classroom")

    assert default_classroom, 'Default classroom was not added'
    assert default_classroom.tracks.any?, 'Default tracks were not added'
    assert default_classroom.tracks.first.checkpoints, 'Default checkpoints were not added'
  end
end
