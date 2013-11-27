require "test_helper"

class InvitationTest < ActiveSupport::TestCase
  before do
    @invitation1 = invitations(:one)
  end

  test "emails are validated for format" do
    invitation = Invitation.new(email: 'Ahmed')
    invitation.valid?

    assert invitation.errors[:email].any?
  end

  test "token created before saving" do
    invitation = Invitation.new(email: 'student@gmail.com')
    assert_equal nil, invitation.token

    invitation.save
    assert_not_nil invitation.token
  end

  test "tokens are not the same" do
    invitation_one = Invitation.create(email: 'student@gmail.com')
    invitation_two = Invitation.create(email: 'student@gmail.com')

    assert_not_equal invitation_one.token, invitation_two.token
  end

  test "signed_up_as_email" do
    assert_equal "foo1@foo.com", @invitation1.email
    assert_equal "student@school.com", @invitation1.signed_up_as_email
  end

  test "name method" do
    assert_equal "jane doe", @invitation1.name
  end
end
