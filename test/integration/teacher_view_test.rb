require 'test_helper'

class TeacherViewTest < Capybara::Rails::TestCase

  test "a teacher should see a list of their classrooms after login" do
    teacher = users(:ahmed)
    login_as(teacher)

    classroom_name = teacher.classrooms.first.name
    assert page.has_content?(classroom_name)

    other_teachers_classroom = users(:paula).classrooms.first.name
    assert !page.has_content?(other_teachers_classroom), "Another teacher's classroom is listed"

    assert current_path == classrooms_path, "Not redirected to user's classrooms"
  end
end