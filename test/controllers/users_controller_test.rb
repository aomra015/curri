require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  before do
    cookies[:auth_token] = users(:teacher1).auth_token
  end

  test "should show profile for current user" do
    get :edit_profile

    assert assigns(:current_user)
    assert :success
  end

  test "should update user details with valid data" do
    post :update_profile, user: {email: 'ahmed@little.com', password: 'password453', password_confirmation: 'password453'}

    assert_equal 'ahmed@little.com', users(:teacher1).reload.email
    assert users(:teacher1).authenticate('password453')
  end

  test "should not update user details with invalid data" do
    post :update_profile, user: {email: '', password: 'password453', password_confirmation: 'password453'}

    assert assigns(:current_user).errors[:email].any?
    assert_template :edit_profile
  end

  test "should not update user details with mismatched passwords" do
    post :update_profile, user: {email: 'ahmed@little.com', password: 'password453', password_confirmation: 'password999'}

    assert assigns(:current_user).errors[:password_confirmation].any?
    assert_template :edit_profile
  end
end