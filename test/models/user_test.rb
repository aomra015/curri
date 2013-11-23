require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @blank_user = User.new
    @blank_user.invalid?
    @teacher = users(:ahmed)
    @student = users(:student)
    @classroom = classrooms(:one)
    @invitation1 = invitations(:one)
  end

  test "email must not be empty" do
    assert @blank_user.errors[:email].any?
  end

  test "email must be formated correctly" do
    user = User.new(email: 'ahmed')
    user.valid?
    assert user.errors[:email].any?
  end

  test "student? method" do
    assert_equal true, @student.student?
    assert_equal false, @student.teacher?
  end

  test "teacher? method" do
    assert_equal false, @teacher.student?
    assert_equal true, @teacher.teacher?
  end

  test "needs_help method" do
    assert_equal false, @student.needs_help?(@classroom)
    @invitation1.toggle(:help).save
    assert_equal true, @student.needs_help?(@classroom)
  end

end
