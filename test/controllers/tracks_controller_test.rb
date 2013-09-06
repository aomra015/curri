require 'test_helper'

class TracksControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:ahmed).id
  end

  test "get list of tracks" do
    get :index, classroom_id: classrooms(:one)
    assert assigns(:tracks)
    assert :success
  end

  test "show single track" do
    get :show, classroom_id: classrooms(:one), id: tracks(:one)
    assert assigns(:track)
    assert :success
  end

  test "get new track form" do
    get :new, classroom_id: classrooms(:one)
    assert assigns(:track)
    assert :success
  end

  test "create track" do
    assert_difference 'Track.count' do
      post :create, classroom_id: classrooms(:one), track: {name: "Test Track"}
    end

    assert_redirected_to classroom_tracks_path(assigns(:classroom))
  end

  test "get edit track form" do
    get :edit, classroom_id: classrooms(:one), id: tracks(:one)
    assert_equal tracks(:one), assigns(:track)
    assert :success
  end

  test "update track" do
    patch :update, classroom_id: classrooms(:one), id: tracks(:one), track: {name: "Changed name" }

    track = Track.find(tracks(:one))
    assert_equal "Changed name", track.name
    assert_redirected_to classroom_track_path(assigns(:classroom), assigns(:track))
  end
end
