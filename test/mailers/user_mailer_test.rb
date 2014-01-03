require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "password_reset" do
    mail = users(:teacher1).send_password_reset

    assert_equal "Password Reset Instructions", mail.subject
    assert_equal [users(:teacher1).email], mail.to
    assert_equal ["ahmed@aomran.com"], mail.from
    assert_match "To reset your password please click the link below.", mail.body.encoded
  end

end
