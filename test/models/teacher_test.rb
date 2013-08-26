require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  test "add default classroom to teacher role" do
    teacher = Teacher.create

    default_classroom = teacher.classrooms.find_by(name: "Sample Classroom")

    assert default_classroom, 'Default classroom was not added'
    assert default_classroom.tracks.any?, 'Default tracks were not added'
    assert default_classroom.tracks.first.checkpoints, 'Default checkpoints were not added'
  end
end
