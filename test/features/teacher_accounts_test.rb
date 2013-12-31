require 'test_helper'

class TeacherAccountsTest < Capybara::Rails::TestCase

  test "a teacher can signup for an account" do
    visit register_path
    fill_in :user_email, with: 'paula@littlefrance.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Register'

    assert page.has_css?('#logout-link')
    assert_equal classrooms_path, current_path
  end
end