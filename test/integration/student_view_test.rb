require 'test_helper'

class StudentViewTest < Capybara::Rails::TestCase

  test "a student can rate checkpoints" do
    login_as(users(:student))

    click_link "Ahmed's Intro To Curry"
    click_link "First Track"

    assert page.has_content?("Can build a thing")

    assert_difference 'Rating.count' do
      click_button 'Totally Understand'
    end

    assert_equal users(:student).classrole, Rating.last.student, 'Student is not associated with the rating'

    assert_equal classroom_track_path(classrooms(:one), tracks(:one)), current_path
  end

end