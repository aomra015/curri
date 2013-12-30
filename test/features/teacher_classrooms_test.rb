require 'test_helper'

class TeacherClassroomsTest < Capybara::Rails::TestCase

  before do
    teacher = users(:ahmed)
    login_as(teacher)
    @classroom = classrooms(:one)
  end

  test "a teacher can add a classroom" do
    click_link "add-classroom"
    assert_equal new_classroom_path, current_path

    fill_in :classroom_name, with: "New classroom name"

    assert_difference 'Classroom.count' do
      click_button 'Create Classroom'
    end
  end

  test "a teacher should see a list of their classrooms after login" do
    assert page.has_content?(@classroom.name)

    other_teachers_classroom = users(:paula).classrooms.first.name
    assert !page.has_content?(other_teachers_classroom), "Another teacher's classroom is listed"

    assert current_path == classrooms_path, "Not redirected to user's classrooms"
  end

  test "a teacher can edit classrooms" do
    click_link @classroom.name

    click_link 'manage-classroom'

    assert_equal edit_classroom_path(@classroom), current_path

    fill_in :classroom_name, with: 'Changed classroom name'
    click_button 'Update Classroom'

    changed_classroom = Classroom.find(@classroom.id)
    assert_equal 'Changed classroom name', changed_classroom.name
  end

  test "a teacher can delete classrooms" do
    click_link @classroom.name

    click_link 'manage-classroom'

    assert_difference 'Classroom.count', -1 do
        click_link 'delete-classroom'
    end
  end
end