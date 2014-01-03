require 'test_helper'

class UserAccountsTest < Capybara::Rails::TestCase

  test "a user can log out" do
    login_as(users(:teacher1))
    log_out

    assert_equal login_path, current_path
  end

  test "a user (teacher) can edit their profile" do
    login_as(users(:teacher1))
    click_link 'account'

    assert_equal edit_profile_path, current_path

    fill_in :user_email, with: 'ahmed@little.com'
    fill_in :user_password, with: 'password453'
    fill_in :user_password_confirmation, with: 'password453'
    click_button 'Submit'

    assert page.has_content?('Profile information updated.')
    assert_equal 'ahmed@little.com', find_field('user_email').value
  end

  test "a user (student) can edit their profile" do
    login_as(users(:student1))
    click_link 'account'

    assert_equal edit_profile_path, current_path

    fill_in :user_email, with: 'stud222@school.com'
    fill_in :user_password, with: 'password453'
    fill_in :user_password_confirmation, with: 'password453'
    click_button 'Submit'

    assert page.has_content?('Profile information updated.')
    assert_equal 'stud222@school.com', find_field('user_email').value
  end

  test "a user gets errors with invalid profile edits" do
    login_as(users(:teacher1))
    click_link 'account'

    fill_in :user_email, with: ''
    fill_in :user_password, with: 'password453'
    fill_in :user_password_confirmation, with: 'password453'
    click_button 'Submit'

    assert page.has_content?("Email can't be blank")
  end

  test "a user gets errors with password mismatch" do
    login_as(users(:teacher1))
    click_link 'account'

    fill_in :user_email, with: 'ahmed@little.com'
    fill_in :user_password, with: 'password453'
    fill_in :user_password_confirmation, with: 'password999'
    click_button 'Submit'

    assert page.has_content?("Password confirmation doesn't match Password")
  end

  test "A user who forgot their password can get a reset email" do
    visit login_path
    click_link 'password-reset'

    fill_in :email, with: 'paula@testmail.com'
    click_button 'password-reset-button'

    assert page.has_content?('Email sent with instructions for resetting password')

  end
end