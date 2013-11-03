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
    fill_in :track_start_date, with: "2013-10-1"
    fill_in :track_start_time, with: "6:30pm"
    fill_in :track_end_date, with: "2013-10-1"
    fill_in :track_end_time, with: "9:30pm"

    assert_difference 'Track.count' do
      click_button 'Create Track'
    end

    assert_equal Time.zone.parse("2013-10-1"), Track.last.start_date
    assert_equal Time.zone.parse('9:30pm'), Track.last.end_time
  end

  test "a teacher can edit a track" do
    click_link @track.name
    click_link 'manage-track'

    assert_equal edit_classroom_track_path(@classroom, @track), current_path

    fill_in :track_name, with: 'Changed track name'
    fill_in :track_start_date, with: "2013-08-10"
    fill_in :track_start_time, with: "6:30pm"
    fill_in :track_end_date, with: "2013-08-10"
    fill_in :track_end_time, with: "11:30pm"
    click_button 'Update Track'

    changed_track = Track.find(@track.id)
    assert_equal 'Changed track name', changed_track.name
    assert_equal Time.zone.parse('2013-08-10'), changed_track.start_date
    assert_equal Time.zone.parse('11:30pm'), changed_track.end_time

  end

  test "a teacher can delete tracks" do
    click_link @track.name
    click_link 'manage-track'

    assert_difference 'Track.count', -1 do
        click_link 'delete-track'
    end
  end

end