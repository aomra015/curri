require 'test_helper'

class CheckpointsControllerTest < ActionController::TestCase
  test "get list of checkpoints" do
    get :index, track_id: tracks(:one)
    assert assigns(:checkpoints)
    assert :success
  end

  test "show single checkpoint" do
    get :show, track_id: tracks(:one), id: checkpoints(:one)
    assert assigns(:checkpoint)
    assert :success
  end

  test "get new checkpoint form" do
    get :new, track_id: tracks(:one)
    assert assigns(:checkpoint)
    assert :success
  end

  test "create checkpoint" do
    assert_difference 'Checkpoint.count' do
      post :create, track_id: tracks(:one), checkpoint: {expectation: "Test Checkpoint"}
    end

    assert_redirected_to track_checkpoint_path(assigns(:track),assigns(:checkpoint))
  end

  test "get edit checkpoint form" do
    get :edit, track_id: tracks(:one), id: checkpoints(:one)
    assert_equal checkpoints(:one), assigns(:checkpoint)
    assert :success
  end

  test "update checkpoint" do

    patch :update, track_id: tracks(:one), id: checkpoints(:one), checkpoint: {expectation: "Changed expectation" }

    checkpoint = Checkpoint.find(checkpoints(:one))
    assert_equal "Changed expectation", checkpoint.expectation
    assert_redirected_to track_checkpoint_path(assigns(:track),assigns(:checkpoint))
  end
end
