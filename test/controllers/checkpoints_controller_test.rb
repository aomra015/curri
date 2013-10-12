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
      post :create, classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint: {expectation: "Test Checkpoint", success_criteria: 'something'}
    end

    assert_redirected_to classroom_track_path(assigns(:classroom), assigns(:track))
  end

  test "show form errors when missing information" do
    post :create, classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint: {expectation: "Test Checkpoint"}

    assert_template :new
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
    assert_redirected_to classroom_track_path(assigns(:classroom), assigns(:track))
  end

  test "delete checkpoint" do
    assert_difference 'Checkpoint.count', -1 do
      delete :destroy, classroom_id: classrooms(:one), track_id: tracks(:one), id: checkpoints(:one)
    end
    assert_redirected_to classroom_track_path(assigns(:classroom), assigns(:track))
  end
end
