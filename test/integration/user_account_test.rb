require 'test_helper'

class UserAccountsTest < Capybara::Rails::TestCase

  test "a user can log out" do
    teacher = users(:ahmed)
    login_as(teacher)
    click_link 'Logout'

    assert current_path == login_path, 'Did not redirect to login page'
  end

  test "A user who forgot their password can get a reset email" do
    visit login_path
    click_link 'password-reset'

    fill_in :email, with: 'paula@testmail.com'
    click_button 'password-reset-button'

    assert page.has_content?('Email sent with instructions for resetting password')

  end
end