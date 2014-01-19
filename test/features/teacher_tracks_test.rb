require 'test_helper'

class TeacherTracksTest < Capybara::Rails::TestCase

  before do
    teacher = users(:teacher1)
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
    click_button 'Create Track'

    assert page.has_content?('New track name')
  end

  test "a teacher can unpublish a published track" do
    click_link @track.name
    click_link 'manage-track'

    uncheck :track_published
    click_button 'Update Track'

    assert page.has_css?('.unpublished-badge'), 'The unpublished track was not labelled'
  end

  test "a teacher can publish an unpublished track" do
    click_link tracks(:two).name
    click_link 'manage-track'

    check :track_published
    click_button 'Update Track'

    assert !page.has_css?('.unpublished-badge'), 'The published track was labelled with Unpublished'
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

    assert page.has_content?('Changed track name')
  end

  test "a teacher can delete tracks" do
    click_link @track.name
    click_link 'manage-track'
    click_link 'delete-track'

    assert !page.has_content?(@track.name)
  end

end