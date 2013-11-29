require "test_helper"

class InvitationMailerTest < ActionMailer::TestCase

  test "invite" do
    invitation = Invitation.create(email: 'student@gmail.com')

    mail = InvitationMailer.invite(invitation)
    assert_equal "Invitation to Curri", mail.subject
    assert_equal ["student@gmail.com"], mail.to
    assert_equal ["hi@curriapp.com"], mail.from
    assert_match invitation.token, mail.body.encoded
    assert_match "claim your invitation.", mail.body.encoded
  end

end
