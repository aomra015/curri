require 'test_helper'

class TeacherInvitationsTest < Capybara::Rails::TestCase

  before do
    @teacher = users(:ahmed)
    @student_email = users(:student).email
    login_as(@teacher)
  end

  test "teacher can invite students" do
    assert_difference 'Invitation.count' do
      invite_students(@teacher, @student_email)
    end

    assert_equal classroom_tracks_path(@classroom), current_path
    assert page.has_content?('Invitations Sent')

    last_email = ActionMailer::Base.deliveries.last

    assert_equal [@student_email], last_email.to
  end

  test "teacher should see list of invited students" do
    invite_students(@teacher, @student_email)

    click_link 'manage-students'
    assert page.has_content?(@student_email), 'Email of invited student not listed'
  end

  test "teacher can cancel invitations" do
    invite_students(@teacher, @student_email)

    invitation = Invitation.last
    click_link 'manage-students'

    within "#invitation_#{invitation.id}" do
      assert_difference 'Invitation.count', -1 do
        click_link 'Remove'
      end
    end

    assert_equal new_classroom_invitation_path(@classroom), current_path
  end
end