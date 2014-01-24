require 'test_helper'

class StudentRatingsTest < Capybara::Rails::TestCase

  test "a student can rate checkpoints" do
    Pusher.stubs(:trigger)

    student = users(:student1)
    login_as(student)

    click_link classrooms(:one).name
    click_link tracks(:one).name

    checkpoint = checkpoints(:one)
    assert page.has_content?(checkpoint.expectation)


    within "#checkpoint_#{checkpoint.id}" do
      click_link 'Totally Understand'
    end

    assert find("#checkpoint_#{checkpoint.id} .choices-toggle").has_css?('.happy')
  end

end