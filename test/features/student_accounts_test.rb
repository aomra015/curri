require 'test_helper'

class StudentAccountsTest < Capybara::Rails::TestCase

  before do
    # Teacher
    teacher = users(:ahmed)
    login_as(teacher)
    invite_students(teacher, "valid@email.com")
    @invitation = Invitation.last
    log_out

    # Student
    visit students_new_path(@invitation.token)
  end

  test "a student can accept invitation and create an account" do
    fill_in :user_email, with: 'student@gmail.com'
    fill_in :user_first_name, with: 'jane'
    fill_in :user_last_name, with: 'doe'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'register-student'

    assert page.has_css?('#logout-link')
    assert page.has_content?(@invitation.classroom.name)
  end

  test "student with account can claim invitation without sign up" do
    click_link 'skip this step'
    assert_equal students_login_path(@invitation.token), current_path, 'Did not go to page where students can log in to claim invitation'

    fill_in :user_email, with: users(:student).email
    fill_in :user_password, with: 'password123'
    click_button 'Login & Claim'

    assert page.has_css?('#logout-link')
    assert page.has_content?(@invitation.classroom.name)
  end
end