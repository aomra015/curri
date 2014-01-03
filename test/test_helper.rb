ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/rails/capybara'
require 'minitest/colorize'
require 'mocha/setup'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def login_as(user)
    visit login_path
    fill_in :email, with: user.email
    fill_in :password, with: 'password123'
    click_button 'Login'
  end

  def log_out
    click_link 'logout-link'
  end

  def manage_students(teacher)
    click_link teacher.classrooms.first.name
    click_link 'manage-students'
  end

  def invite_students(student_emails)
    fill_in :invitation_emails, with: student_emails
    click_button 'invite-button'
    Invitation.last
  end
end