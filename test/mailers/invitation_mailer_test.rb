require "test_helper"

class InvitationMailerTest < ActionMailer::TestCase

  test "invite" do
    invitation = invitations(:one)
    mail = InvitationMailer.invite(invitation)

    assert_equal "Invitation to Curri", mail.subject
    assert_equal ["foo1@foo.com"], mail.to
    assert_equal ["hi@curriapp.com"], mail.from
    assert_match invitation.token, mail.body.encoded
    assert_match "claim your invitation.", mail.body.encoded
  end

end
