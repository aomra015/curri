require 'test_helper'

class AnalyticsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:ahmed).id
  end

  test "get analytics for classroom tracks" do
    get :index, id: classrooms(:one)

    assert_equal classrooms(:one).tracks, assigns(:tracks)

    assert :success
  end

  test "get scoped analytics for classroom tracks" do
    get :scope, id: classrooms(:one)

    assert_equal classrooms(:one).tracks, assigns(:tracks)

    assert :success

  end
end
