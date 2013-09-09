require 'test_helper'

class TracksTest < Capybara::Rails::TestCase

  test "a teacher can add checkpoints to a track" do
    teacher = users(:ahmed)
    login_as(teacher)

    classroom = teacher.classrooms.first
    click_link classroom.name

    track = classroom.tracks.first
    click_link track.name
    assert_equal classroom_track_path(classroom, track), current_path

    click_link 'Add Checkpoints'
    assert_equal new_classroom_track_checkpoint_path(classroom, track), current_path

    fill_in :checkpoint_expectation, with: 'Can do something'
    fill_in :checkpoint_success_criteria, with: 'Did something'

    assert_difference 'track.checkpoints.count' do
      click_button 'Create Checkpoint'
    end

  end

end