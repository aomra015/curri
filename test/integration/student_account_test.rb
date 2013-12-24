require 'test_helper'

class StudentAccountsTest < Capybara::Rails::TestCase

  before do
    @teacher = users(:ahmed)
    login_as(@teacher)
    student_email = users(:student).email
    invite_students(@teacher, student_email)
  end

  test "a student can accept invitation and create an account" do
    invitation = Invitation.last

    visit students_new_path(invitation.token)

    fill_in :user_email, with: 'student@gmail.com'
    fill_in :user_first_name, with: 'jane'
    fill_in :user_last_name, with: 'doe'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'

    assert_difference 'User.count' do
      click_button 'register-student'
    end

  end

  test "student with account can claim invitation without sign up" do
    within 'ul.nav' do
      click_link 'logout-link'
    end
    assert_equal current_path, login_path

    invitation = Invitation.last

    visit students_new_path(invitation.token)

    click_link 'skip this step'
    assert_equal students_login_path(invitation.token), current_path, 'Did not go to page where students can log in to claim invitation'

    fill_in :user_email, with: users(:student).email
    fill_in :user_password, with: 'password123'
    click_button 'Login & Claim'

    assert_equal users(:student).classrole, Invitation.last.student, 'Student was not added to the classroom'
  end

  test "currently logged in student can claim invitation without sign up" do
    within 'ul.nav' do
      click_link 'logout-link'
    end
    login_as(users(:student))

    invitation = Invitation.last
    visit students_new_path(invitation.token)

    assert_equal students_login_path(invitation.token), current_path, 'Did not redirect to page where students can log in to claim invitation'
  end
end