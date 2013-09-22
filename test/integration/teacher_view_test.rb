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

  test "teacher can invite students" do
    teacher = users(:ahmed)
    student_email = 'mystudent@gmail.com'
    login_as(teacher)

    assert_difference 'Invitation.count' do
      invite_students(teacher, student_email)
    end

    assert_equal classroom_tracks_path(@classroom), current_path
    assert page.has_content?('Invitations Sent')

    last_email = ActionMailer::Base.deliveries.last

    assert_equal ['mystudent@gmail.com'], last_email.to
  end

  test "teacher should see list of invited students" do
    teacher = users(:ahmed)
    login_as(teacher)
    student_email = 'mystudent@gmail.com'
    invite_students(teacher, student_email)

    click_link 'Invite Students'
    assert page.has_content?(student_email), 'Email of invited student not listed'
  end
end