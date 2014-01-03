require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get login form" do
    get :new
    assert_response :success
  end

  test "should sign current user with valid data" do
    post :create, email: "aomra@gmail.com", password: "password123"

    assert_equal users(:teacher1).id, session[:user_id]
  end

  test "should not sign current user in with invalid data" do
    post :create, email: "aomra@gmail.com", password: "password999"

    assert_template :new
    assert_equal "Email or password are not correct", flash[:alert]
  end

  test "should sign out current user" do
    delete :destroy

    assert_equal nil, session[:user_id]
    assert_redirected_to login_path
  end

end
