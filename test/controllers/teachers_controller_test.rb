require 'test_helper'

class TeachersControllerTest < ActionController::TestCase
  test "should get sign up form" do
    get :new
    assert_response :success
  end

  test "should create a teacher" do
    assert_difference 'User.count' do
      post :create, user: {username: "misty", email: "misty@aomran.com", password: "likeskoi", password_confirmation: "likeskoi"}
    end
    assert_redirected_to classrooms_path
  end

end
