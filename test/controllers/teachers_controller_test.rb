require 'test_helper'

class TeachersControllerTest < ActionController::TestCase

  before do
    @params = {
      email: "misty@aomran.com",
      password: "likeskoi",
      password_confirmation: "likeskoi"
    }
  end

  test "should get sign up form" do
    get :new

    assert assigns(:user)
    assert_response :success
  end

  test "should create a teacher with valid data" do
    assert_difference 'User.count' do
      post :create, user: @params
    end
    assert_redirected_to classrooms_path
  end

  test "should log teacher in after signup" do
    post :create, user: @params

    assert_equal assigns(:user).id, session[:user_id]
  end

  test "should not create teacher with invalid data" do
    @params[:email] = nil
    post :create, user: @params

    assert_template :new
    assert assigns(:user).errors[:email].any?
  end

end
