require "test_helper"

class InvitationTest < ActiveSupport::TestCase

  test "token created before saving" do
    invitation = Invitation.new
    assert_equal nil, invitation.token

    invitation.save
    assert_not_nil invitation.token
  end

  test "tokens are not the same" do
    invitation_one = Invitation.create
    invitation_two = Invitation.create

    assert_not_equal invitation_one.token, invitation_two.token
  end

end
