require 'test_helper'

class TeacherCheckpointsTest < Capybara::Rails::TestCase

  before do
    teacher = users(:teacher1)
    login_as(teacher)

    @classroom = classrooms(:one)
    click_link @classroom.name

    @track = tracks(:one)
    click_link @track.name
  end

  test "a teacher can edit checkpoints" do
    checkpoint = checkpoints(:one)

    within "#checkpoint_#{checkpoint.id}" do
        click_link 'edit-checkpoint'
    end

    assert_equal edit_classroom_track_checkpoint_path(@classroom, @track, checkpoint), current_path

    fill_in :checkpoint_expectation, with: 'Changed expectation'
    fill_in :checkpoint_success_criteria, with: 'Changed success criteria'
    click_button 'Update Checkpoint'

    within "#checkpoint_#{checkpoint.id}" do
        assert page.has_content?('Changed expectation')
        assert page.has_content?('Changed success criteria')
    end
  end

  test "a teacher can delete checkpoints" do
    checkpoint = checkpoints(:one)
    within "#checkpoint_#{checkpoint.id}" do
      click_link 'delete-checkpoint'
    end

    assert page.has_no_css?("#checkpoint_#{checkpoint.id}")
  end
end