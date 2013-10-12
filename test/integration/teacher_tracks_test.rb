require 'test_helper'

class TeacherTracksTest < Capybara::Rails::TestCase

  before do
    teacher = users(:ahmed)
    login_as(teacher)

    @classroom = classrooms(:one)
    click_link @classroom.name

    @track = tracks(:one)
    click_link @track.name
  end

  test "a teacher can add checkpoints to a track" do
    assert_equal classroom_track_path(@classroom, @track), current_path

    click_link 'Add Checkpoints'
    assert_equal new_classroom_track_checkpoint_path(@classroom, @track), current_path

    fill_in :checkpoint_expectation, with: 'Can build a thing'
    fill_in :checkpoint_success_criteria, with: 'something'

    assert_difference '@track.checkpoints.count' do
      click_button 'Create Checkpoint'
    end
  end

  test "a teacher can edit checkpoints" do
    checkpoint = checkpoints(:one)

    within "#checkpoint#{checkpoint.id}" do
        click_link 'Edit'
    end

    assert_equal edit_classroom_track_checkpoint_path(@classroom, @track, checkpoint), current_path

    fill_in :checkpoint_expectation, with: 'Changed expectation'
    fill_in :checkpoint_success_criteria, with: 'some criteria'
    click_button 'Update Checkpoint'
  end

end