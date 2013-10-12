require 'test_helper'

class TeacherTracksTest < Capybara::Rails::TestCase

  before do
    teacher = users(:ahmed)
    login_as(teacher)

    @classroom = classrooms(:one)
    click_link @classroom.name

    @track = tracks(:one)
  end

  test "a teacher can add a track" do
    click_link "add-track"
    assert_equal new_classroom_track_path(@classroom), current_path

    fill_in :track_name, with: "New track name"

    assert_difference 'Track.count' do
      click_button 'Create Track'
    end
  end

  test "a teacher can edit a track" do
    click_link @track.name
    click_link 'manage-track'

    assert_equal edit_classroom_track_path(@classroom, @track), current_path

    fill_in :track_name, with: 'Changed track name'
    click_button 'Update Track'

    changed_track = Track.find(@track.id)
    assert_equal 'Changed track name', changed_track.name
  end

  test "a teacher can delete tracks" do
    click_link @track.name
    click_link 'manage-track'

    assert_difference 'Track.count', -1 do
        click_link 'delete-track'
    end
  end

end