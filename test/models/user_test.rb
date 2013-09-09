require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @blank_user = User.new
    @blank_user.invalid?
  end

  test "email must not be empty" do
    assert @blank_user.errors[:email].any?
  end

  test "email must be formated correctly" do
    user = User.new(email: 'ahmed')
    user.valid?

    assert user.errors[:email].any?
  end
end
