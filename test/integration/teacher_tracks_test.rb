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

  test "a teacher can add a track" do
  end

  test "a teacher can edit a track" do

  end

  test "a teacher can delete tracks" do
    click_link 'manage-track'

    assert_difference 'Track.count', -1 do
        click_link 'delete-track'
    end
  end

end