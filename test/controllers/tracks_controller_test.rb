require 'test_helper'

class TracksControllerTest < ActionController::TestCase

  before do
    cookies[:auth_token] = users(:teacher1).auth_token
  end

  test "get list of tracks" do
    get :index, classroom_id: classrooms(:one)
    assert assigns(:tracks)
    assert :success
  end

  test "teacher should see unpublished tracks" do
    get :index, classroom_id: classrooms(:one)
    tracks = assigns(:tracks)
    assert_equal 2, tracks.length
    assert tracks.include?(tracks(:two))
  end

  test "student should not see unpublished tracks" do
    cookies[:auth_token] = users(:student1).auth_token
    get :index, classroom_id: classrooms(:one)

    tracks = assigns(:tracks)
    assert_equal 1, tracks.length
    assert_equal false, tracks.include?(tracks(:two))
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

  test "should create track with valid data" do
    assert_difference 'Track.count' do
      post :create, classroom_id: classrooms(:one), track: {name: "Test Track", start_date: "2013-10-1", start_time: "6:30pm", end_date: "2013-10-1", end_time: "9:30pm"}
    end

    assert_redirected_to classroom_tracks_path(assigns(:classroom))
  end

  test "should not create track with invalid data" do
    post :create, classroom_id: classrooms(:one), track: {name: nil}
    assert_template :new
  end

  test "should create track with note" do
    post :create, classroom_id: classrooms(:one), track: {name: "Test Track", note: "Notes can be found <a href='google.com'>here</a>"}
    assert Track.last.note
  end

  test "should correctly create time/date attributes" do
    post :create, classroom_id: classrooms(:one), track: {name: "Test Track", start_date: "2013-10-1", start_time: "6:30pm", end_date: "2013-10-1", end_time: "9:30pm"}

    assert_equal Time.zone.parse("2013-10-1 6:30pm").to_s, Track.last.start_time.to_s
    assert_equal Time.zone.parse('2013-10-1 9:30pm').to_s, Track.last.end_time.to_s
  end

  test "should set end_time to end_of_day if no time is provided" do
    post :create, classroom_id: classrooms(:one), track: {name: "Test Track", start_date: "2013-10-1", end_date: "2013-10-1" }

    assert_equal Time.zone.parse('2013-10-1 11:59:59pm').to_s, Track.last.end_time.to_s
  end

  test "get edit track form" do
    get :edit, classroom_id: classrooms(:one), id: tracks(:one)
    assert_equal tracks(:one), assigns(:track)
    assert :success
  end

  test "should update track with valid data" do
    patch :update, classroom_id: classrooms(:one), id: tracks(:one), track: {name: "Changed name" }

    track = Track.find(tracks(:one))
    assert_equal "Changed name", track.name
    assert_redirected_to classroom_track_path(assigns(:classroom), assigns(:track))
  end

  test "should not update track with invalid data" do
    patch :update, classroom_id: classrooms(:one), id: tracks(:one), track: {name: nil }

    assert_template :edit
  end

  test "should add note to track" do
    patch :update, classroom_id: classrooms(:one), id: tracks(:one), track: {note: "Notes can be found <a href='google.com'>here</a>"}
    assert tracks(:one).reload.note
  end

  test "should be able to unpublish a track" do
    patch :update, classroom_id: classrooms(:one), id: tracks(:one), track: {published: false }

    assert_equal false, tracks(:one).reload.published
  end

  test "should be able to publish a track" do
    patch :update, classroom_id: classrooms(:one), id: tracks(:two), track: {published: true }

    assert tracks(:two).reload.published
  end

  test "should correctly update time/date attributes" do
    patch :update, classroom_id: classrooms(:one), id: tracks(:one), track: {start_date: "2013-08-10", start_time: "6:30pm", end_date: "2013-08-10", end_time: "11:30pm"}

    assert_equal Time.zone.parse('2013-08-10 6:30pm').to_s, tracks(:one).reload.start_time.to_s
    assert_equal Time.zone.parse('2013-08-10 11:30pm').to_s, tracks(:one).reload.end_time.to_s
  end

  test "delete track" do
    assert_difference 'Track.count', -1 do
      delete :destroy, classroom_id: classrooms(:one), id: tracks(:one)
    end
    assert_redirected_to classroom_tracks_path(assigns(:classroom))
  end

  test "should sort tracks" do
    post :sort, classroom_id: classrooms(:one), track: [tracks(:two).id, tracks(:one)]

    assert_equal 1, tracks(:two).reload.position
    assert_equal 2, tracks(:one).reload.position
  end
end
