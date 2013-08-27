require 'test_helper'

class UserAccountsTest < Capybara::Rails::TestCase

  test "a user can log out" do
    teacher = users(:ahmed)
    login_as(teacher)
    click_link 'Logout'

    assert current_path == login_path, 'Did not redirect to login page'
  end
end