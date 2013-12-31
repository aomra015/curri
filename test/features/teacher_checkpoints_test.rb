require 'test_helper'

class TeacherCheckpointsTest < Capybara::Rails::TestCase

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

    fill_in :checkpoint_expectation, with: 'New expectation'
    fill_in :checkpoint_success_criteria, with: 'New success criteria'
    click_button 'Create Checkpoint'

    checkpoint = Checkpoint.last
    within "#checkpoint#{checkpoint.id}" do
        assert page.has_content?('New expectation')
        assert page.has_content?('New success criteria')
    end
  end

  test "a teacher can edit checkpoints" do
    checkpoint = checkpoints(:one)

    within "#checkpoint#{checkpoint.id}" do
        click_link 'edit-checkpoint'
    end

    assert_equal edit_classroom_track_checkpoint_path(@classroom, @track, checkpoint), current_path

    fill_in :checkpoint_expectation, with: 'Changed expectation'
    fill_in :checkpoint_success_criteria, with: 'Changed success criteria'
    click_button 'Update Checkpoint'

    within "#checkpoint#{checkpoint.id}" do
        assert page.has_content?('Changed expectation')
        assert page.has_content?('Changed success criteria')
    end
  end

  test "a teacher can delete checkpoints" do
    checkpoint = checkpoints(:one)
    within "#checkpoint#{checkpoint.id}" do
      click_link 'delete-checkpoint'
    end

    assert page.has_no_css?("#checkpoint#{checkpoint.id}")
  end
end