require 'test_helper'

class ClassroomsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:ahmed).id
  end

  test "get list of classrooms" do
    get :index
    assert assigns(:classrooms)
    assert :success
  end

  test "show single classroom" do
    get :show, id: classrooms(:one)
    assert assigns(:classroom)
    assert :success
  end

  test "get new classroom form" do
    get :new
    assert assigns(:classroom)
    assert :success
  end

  test "create classroom" do
    assert_difference 'Classroom.count' do
      post :create, classroom: {name: "Test classroom"}
    end

    assert_redirected_to classrooms_path
  end

  test "get edit classroom form" do
    get :edit, id: classrooms(:one)
    assert_equal classrooms(:one), assigns(:classroom)
    assert :success
  end

  test "update classroom" do
    patch :update, id: classrooms(:one), classroom: {name: "Changed name" }

    classroom = Classroom.find(classrooms(:one).id)
    assert_equal "Changed name", classroom.name
    assert_redirected_to classroom_tracks_path(assigns(:classroom))
  end

  test "delete classroom" do
    assert_difference 'Classroom.count', -1 do
      delete :destroy, id: classrooms(:one)
    end
    assert_redirected_to classrooms_path
  end

end
