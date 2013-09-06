require 'test_helper'

class StudentAccountsTest < Capybara::Rails::TestCase

  test "a student can accept invitation and create an account" do
    teacher = users(:ahmed)
    student_email = 'mystudent@gmail.com'

    login_as(teacher)
    invite_student(teacher, student_email)

    invitation = Invitation.last

    visit claim_invitation_path(invitation.token)

    fill_in :user_email, with: 'student@gmail.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'

    assert_difference 'User.count' do
      click_button 'register-student'
    end

  end

  test "student with account can claim invitation without sign up" do
    skip
  end

  test "logged in student can claim invitation" do
    skip
  end
end