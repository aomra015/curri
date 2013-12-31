require 'test_helper'

class TeacherInvitationsTest < Capybara::Rails::TestCase

  before do
    @teacher = users(:ahmed)
    @student_email = users(:student).email
    login_as(@teacher)
    @invitation = Invitation.last
  end

  test "teacher can invite students" do
    classroom = @teacher.classrooms.first
    click_link classroom.name

    click_link 'manage-students'
    assert_equal new_classroom_invitation_path(classroom), current_path

    fill_in :invitation_emails, with: @student_emails
    click_button 'Send Invitation'

    assert page.has_content?('Invitations Sent')
    within "#invitation_#{@invitation.id}" do
      assert page.has_content?(@student_email), 'Email of invited student not listed'
    end
  end

  test "teacher can remove invitations" do
    invite_students(@teacher, @student_email)

    within "#invitation_#{@invitation.id}" do
      click_link 'Remove'
    end

    assert page.has_no_css?("#invitation_#{@invitation.id}")
  end
end