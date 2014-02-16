require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "password_reset" do
    users(:teacher1).generate_token(:password_reset_token)
    users(:teacher1).save
    mail = UserMailer.password_reset(users(:teacher1).id)

    assert_equal "Password Reset Instructions", mail.subject
    assert_equal [users(:teacher1).email], mail.to
    assert_equal ["hi@curriapp.com"], mail.from
    assert_match "To reset your password please click the link below.", mail.body.encoded
  end

end
