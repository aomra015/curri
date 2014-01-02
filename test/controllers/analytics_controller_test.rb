require 'test_helper'

class AnalyticsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:ahmed).id
    @classroom = classrooms(:one)
    @track = tracks(:one)
  end

  test "get analytics for classroom tracks" do
    get :show, classroom_id: @classroom.id, track_id: @track.id

    assert_equal @track, assigns(:track)
    assert :success
  end

  test "by default sets phase to Realtime" do
    get :show, classroom_id: @classroom.id, track_id: @track.id

    assert_equal "Realtime", assigns(:phase).state
  end

  test "sets phase to Realtime" do
    get :show, classroom_id: @classroom.id, track_id: @track.id, phase_state: "Realtime"

    assert_equal "Realtime", assigns(:phase).state
  end

  test "sets phase to Before" do
    get :show, classroom_id: @classroom.id, track_id: @track.id, phase_state: "Before"

    assert_equal "Before", assigns(:phase).state
  end

  test "sets phase to During" do
    get :show, classroom_id: @classroom.id, track_id: @track.id, phase_state: "During"

    assert_equal "During", assigns(:phase).state
  end

  test "sets phase to After" do
    get :show, classroom_id: @classroom.id, track_id: @track.id, phase_state: "After"

    assert_equal "After", assigns(:phase).state
  end
end
