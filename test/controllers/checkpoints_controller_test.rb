require 'test_helper'

class CheckpointsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:teacher1).id
    @params = {
      classroom_id: classrooms(:one),
      track_id: tracks(:one),
      checkpoint: {
        expectation: "Test Checkpoint",
        success_criteria: 'something'
      }
    }
    @update_params = {
      classroom_id: classrooms(:one),
      track_id: tracks(:one),
      id: checkpoints(:one),
      checkpoint: {
        expectation: "Changed expectation"
      }
    }
  end

  test "get new checkpoint form" do
    get :new, classroom_id: classrooms(:one), track_id: tracks(:one)
    assert assigns(:checkpoint)
    assert :success
  end

  test "should create checkpoint with valid data" do
    assert_difference 'Checkpoint.count' do
      post :create, @params
    end

    assert_redirected_to classroom_track_path(assigns(:classroom), assigns(:track))
  end

  test "should not create checkpoint with invalid data" do
    @params[:checkpoint][:success_criteria] = nil
    post :create, @params

    assert_template :new
  end

  test "get edit checkpoint form" do
    get :edit, classroom_id: classrooms(:one), track_id: tracks(:one), id: checkpoints(:one)
    assert_equal checkpoints(:one), assigns(:checkpoint)
    assert :success
  end

  test "should update checkpoint with valid data" do
    patch :update, @update_params

    checkpoint = Checkpoint.find(checkpoints(:one))
    assert_equal "Changed expectation", checkpoint.expectation
    assert_redirected_to classroom_track_path(assigns(:classroom), assigns(:track))
  end

  test "should not update checkpoint with invalid data" do
    @update_params[:checkpoint][:success_criteria] = nil
    patch :update, @update_params

    assert_template :edit
  end

  test "delete checkpoint" do
    assert_difference 'Checkpoint.count', -1 do
      delete :destroy, classroom_id: classrooms(:one), track_id: tracks(:one), id: checkpoints(:one)
    end
    assert_redirected_to classroom_track_path(assigns(:classroom), assigns(:track))
  end

  test "should sort checkpoints" do
    first_checkpoint = checkpoints(:one)
    second_checkpoint = checkpoints(:two)
    third_checkpoint = checkpoints(:noratings)
    fourth_checkpoint = checkpoints(:onerating)

    post :sort, classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint: [first_checkpoint.id, fourth_checkpoint.id, third_checkpoint.id, second_checkpoint.id]

    assert_equal 1, first_checkpoint.reload.position
    assert_equal 2, fourth_checkpoint.reload.position
    assert_equal 3, third_checkpoint.reload.position
    assert_equal 4, second_checkpoint.reload.position
  end
end
