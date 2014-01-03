require 'test_helper'

class TeacherInvitationsTest < Capybara::Rails::TestCase

  before do
    @teacher = users(:teacher1)
    @student_email = "foo@fakemail.com"
    login_as(@teacher)
  end

  test "teacher can invite students" do
    manage_students(@teacher)

    assert_equal new_classroom_invitation_path(@teacher.classrooms.first), current_path

    invitation = invite_students(@student_email)

    assert page.has_content?('Invitations Sent')
    within "#invitation_#{invitation.id}" do
      assert page.has_content?(@student_email), 'Email of invited student not listed'
    end
  end

  test "teacher can remove invitations" do
    manage_students(@teacher)
    invitation = invite_students(@student_email)

    within "#invitation_#{invitation.id}" do
      click_link 'remove_button'
    end

    assert page.has_no_css?("#invitation_#{invitation.id}")
  end
end