require 'test_helper'

class AnalyticsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:ahmed).id
  end

  test "get analytics for classroom tracks" do
    classroom = classrooms(:one)
    track = classrooms(:one).tracks.first

    get :show, classroom_id: classrooms(:one), track_id: track.id

    assert_not_nil assigns(:track)
    assert :success
  end
end
