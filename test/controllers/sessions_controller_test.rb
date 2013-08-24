require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get login form" do
    get :new
    assert_response :success
  end

  test "should log user in" do
    post :create, email: "aomra@gmail.com", password: "password123"

    assert_equal users(:ahmed).id, session[:user_id]
  end

end
