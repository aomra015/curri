require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    session[:user_id] = users(:paula).id
  end

  test "should show profile for current user" do
    get :edit_profile

    assert assigns(:current_user), 'current user object not assigned to view'
    assert :success
  end
end