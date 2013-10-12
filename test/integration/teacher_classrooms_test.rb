require 'test_helper'

class TeacherClassroomsTest < Capybara::Rails::TestCase

  test "a teacher should see a list of their classrooms after login" do
    teacher = users(:ahmed)
    login_as(teacher)

    classroom_name = teacher.classrooms.first.name
    assert page.has_content?(classroom_name)

    other_teachers_classroom = users(:paula).classrooms.first.name
    assert !page.has_content?(other_teachers_classroom), "Another teacher's classroom is listed"

    assert current_path == classrooms_path, "Not redirected to user's classrooms"
  end

  test "a teacher can edit classrooms" do
    teacher = users(:ahmed)
    login_as(teacher)

    classroom = classrooms(:one)
    click_link classroom.name

    click_link 'manage-classroom'

    assert_equal edit_classroom_path(classroom), current_path

    fill_in :classroom_name, with: 'Changed classroom name'
    click_button 'Update Classroom'

    changed_classroom = Classroom.find(classrooms(:one).id)
    assert_equal 'Changed classroom name', changed_classroom.name
  end

  test "a teacher can delete classrooms" do
    teacher = users(:ahmed)
    login_as(teacher)

    classroom = classrooms(:one)
    click_link classroom.name

    click_link 'manage-classroom'

    assert_difference 'Classroom.count', -1 do
        click_link 'delete-classroom'
    end
  end
end