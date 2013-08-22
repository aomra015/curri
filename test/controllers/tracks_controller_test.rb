require 'test_helper'

class TracksControllerTest < ActionController::TestCase
  test "get list of tracks" do
    get :index
    assert assigns(:tracks)
    assert :success
  end

  test "show single track" do
    get :show, id: tracks(:one)
    assert assigns(:track)
    assert :success
  end

  test "get new track form" do
    get :new
    assert assigns(:track)
    assert :success
  end

  test "create track" do
    assert_difference 'Track.count' do
      post :create, track: {name: "Test Track"}
    end

    assert_redirected_to track_path(assigns(:track))
  end

  test "get edit track form" do
    get :edit, id: tracks(:one)
    assert_equal tracks(:one), assigns(:track)
    assert :success
  end

  test "update track" do
    track = Track.create(name: "Track name")

    patch :update, id: track, track: {name: "Changed name" }

    track = Track.find(track.id)
    assert_equal "Changed name", track.name
    assert_redirected_to track_path(assigns(:track))
  end
end
