require 'simplecov'
#SimpleCov.start

ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/rails/capybara'
require 'minitest/colorize'

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

  def invite_students(teacher, student_emails)
    @classroom = teacher.classrooms.first
    click_link @classroom.name
    assert_equal classroom_tracks_path(@classroom), current_path

    click_link 'Invite Students'
    assert_equal new_classroom_invitation_path(@classroom), current_path

    fill_in :invitation_emails, with: student_emails
    click_button 'Send Invitation'
  end
end

require "mocha/setup"