require 'test_helper'

class ClassroomsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:teacher1).id
  end

  test "get list of classrooms" do
    get :index
    assert assigns(:classrooms)
    assert :success
  end

  test "get new classroom form" do
    get :new
    assert assigns(:classroom)
    assert :success
  end

  test "should create classroom with valid data" do
    assert_difference 'users(:teacher1).classrooms.count' do
      post :create, classroom: {name: "Test classroom"}
    end

    assert_redirected_to classrooms_path
  end

  test "should not create classroom with invalid data" do
    post :create, classroom: { name: nil }

    assert_template :new
  end

  test "get edit classroom form" do
    get :edit, id: classrooms(:one)
    assert_equal classrooms(:one), assigns(:classroom)
    assert :success
  end

  test "should update classroom with valid data" do
    patch :update, id: classrooms(:one), classroom: {name: "Changed name" }

    classroom = Classroom.find(classrooms(:one).id)
    assert_equal "Changed name", classroom.name
    assert_redirected_to classroom_tracks_path(assigns(:classroom))
  end

  test "should not update classroom with invalid data" do
    patch :update, id: classrooms(:one), classroom: {name: nil }

    assert_template :edit
  end

  test "should remove teacher from classroom without deleting classroom" do
    assert_difference 'users(:teacher1).classrooms.count', -1 do
      delete :destroy, id: classrooms(:one)
    end

    assert classrooms(:one).reload
    assert_redirected_to classrooms_path
  end

  test "should remove student from classroom without deleting classroom" do
    session[:user_id] = users(:student1).id

    assert_difference 'users(:student1).classrooms.count', -1 do
      delete :destroy, id: classrooms(:one)
    end

    assert classrooms(:one).reload
    assert_redirected_to classrooms_path
  end

  test "should remove classroom with no teachers or students" do
    session[:user_id] = users(:teacher2).id
    assert_difference 'Classroom.count', -1 do
      delete :destroy, id: classrooms(:three)
    end
  end

  test "should add teacher to classroom" do
    assert_equal 1, users(:teacher1).classrooms.size
    post :join, teacher_token: classrooms(:three).teacher_token

    assert_equal 2, users(:teacher1).classrooms.size
  end

  test "should give error with wrong token" do
    post :join, teacher_token: 'bad-token'

    assert 'Invalid Token', flash[:alert]
    assert_template :new
  end

  test "should not add student to classroom using token" do
    assert_equal 1, users(:student1).classrooms.size

    session[:user_id] = users(:student1).id
    post :join, teacher_token: classrooms(:three).teacher_token

    assert_equal 1, users(:student1).classrooms.size
    assert 'Only a teacher can do that.', flash[:alert]
  end

  test "should not add teacher to a classroom they are already in" do

    assert_no_difference 'users(:teacher1).classrooms.count' do
      post :join, teacher_token: classrooms(:one).teacher_token
    end

    assert_equal 'You have already used this token', flash[:alert]
  end

end
