require 'test_helper'

class TeacherAccountsTest < Capybara::Rails::TestCase

  test "a teacher can signup for an account" do
    visit register_path
    fill_in :user_username, with: 'pjfranzini'
    fill_in :user_email, with: 'paula@littlefrance.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'

    assert_difference 'User.count' do
      click_button 'register-teacher'
    end

    assert current_path == classrooms_path, "Not redirected to user's classrooms"
  end
end