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
    login_as(teacher)

    classroom = teacher.classrooms.first
    click_link classroom.name
    assert_equal classroom_tracks_path(classroom), current_path

    click_link 'Invite Students'
    assert_equal new_classroom_invitation_path(classroom), current_path

    fill_in :invitation_email, with: 'mystudent@gmail.com'

    assert_difference 'Invitation.count' do
      click_button 'invite-button'
    end

    assert_equal classroom_tracks_path(classroom), current_path
    assert page.has_content?('Invitation Sent')

    last_email = ActionMailer::Base.deliveries.last

    assert_equal ['mystudent@gmail.com'], last_email.to

  end
end