require 'test_helper'

class UserAccountsTest < Capybara::Rails::TestCase

  test "a user can log out" do
    teacher = users(:ahmed)
    login_as(teacher)
    click_link 'Logout'

    assert current_path == login_path, 'Did not redirect to login page'
  end

  test "a user (teacher) can edit their profile" do
    login_as(users(:paula))

    click_link('Profile')
    assert current_path == edit_profile_path, 'Not redirected to user edit profile page'

    fill_in :user_email, with: 'paula@little.com'
    fill_in :user_password, with: 'password453'
    fill_in :user_password_confirmation, with: 'password453'

    click_button 'Submit'

    assert current_path == edit_profile_path
    user = User.find(users(:paula).id)
    assert user.email == 'paula@little.com', 'Email was not updated'
    assert user.authenticate('password453')
  end

  test "a user (student) can edit their profile" do
    login_as(users(:student))

    click_link('Profile')
    assert current_path == edit_profile_path, 'Not redirected to user edit profile page'

    fill_in :user_email, with: 'stud222@school.com'
    fill_in :user_password, with: 'password453'
    fill_in :user_password_confirmation, with: 'password453'

    click_button 'Submit'

    assert current_path == edit_profile_path
    user = User.find(users(:student).id)
    assert user.email == 'stud222@school.com', 'Email was not updated'
    assert user.authenticate('password453')
  end

  test "a logged-in user (teacher) gets form errors if their profile edits are invalid (email missing)" do
    login_as(users(:paula))

    click_link('Profile')

    fill_in :user_email, with: ''
    fill_in :user_password, with: 'password453'
    fill_in :user_password_confirmation, with: 'password453'
    click_button 'Submit'

    assert page.has_content?("Email can't be blank")
  end

  test "a logged-in user (teacher) gets form errors if their profile edits are invalid (password mismatch)" do
    login_as(users(:paula))

    click_link('Profile')

    fill_in :user_email, with: 'franzini@mail.com'
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