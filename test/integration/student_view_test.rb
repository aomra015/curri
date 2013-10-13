require 'test_helper'

class StudentViewTest < Capybara::Rails::TestCase

  test "a student can rate checkpoints" do
    student = users(:student)
    login_as(student)
    classroom = student.classrooms.first

    click_link classroom.name
    track = classroom.tracks.first
    click_link track.name

    checkpoint = track.checkpoints.first
    assert page.has_content?(checkpoint.expectation)

    within "#checkpoint#{checkpoint.id}" do
      assert_difference 'Rating.count' do
        click_button 'Totally Understand'
      end
    end

    assert_equal users(:student).classrole, Rating.last.student, 'Student is not associated with the rating'

    assert_equal classroom_track_path(classrooms(:one), tracks(:one)), current_path
  end

end