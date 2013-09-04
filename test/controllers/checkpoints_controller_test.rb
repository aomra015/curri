require 'test_helper'

class CheckpointsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:ahmed).id
  end

  test "get new checkpoint form" do
    get :new, classroom_id: classrooms(:one), track_id: tracks(:one)
    assert assigns(:checkpoint)
    assert :success
  end

  test "create checkpoint" do
    assert_difference 'Checkpoint.count' do
      post :create, classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint: {expectation: "Test Checkpoint"}
    end

    assert_redirected_to classroom_track_checkpoint_path(assigns(:classroom), assigns(:track),assigns(:checkpoint))
  end

  test "get edit checkpoint form" do
    get :edit, classroom_id: classrooms(:one), track_id: tracks(:one), id: checkpoints(:one)
    assert_equal checkpoints(:one), assigns(:checkpoint)
    assert :success
  end

  test "update checkpoint" do
    patch :update, classroom_id: classrooms(:one), track_id: tracks(:one), id: checkpoints(:one), checkpoint: {expectation: "Changed expectation" }

    checkpoint = Checkpoint.find(checkpoints(:one))
    assert_equal "Changed expectation", checkpoint.expectation
    assert_redirected_to classroom_track_checkpoint_path(assigns(:classroom), assigns(:track),assigns(:checkpoint))
  end
end
