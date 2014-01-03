require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase

  before do
    users(:teacher2).send_password_reset
    @token = users(:teacher2).reload.password_reset_token
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should send the password reset" do
    post :create, email: 'franzini@paula.com'
    assert_equal users(:teacher2), assigns(:user)
    assert_respond_to(assigns(:user), :send_password_reset)
    assert_redirected_to login_path
  end

  test "should show password edit form" do
    get :edit, id: @token

    assert_equal users(:teacher2), assigns(:user)
    assert :success
  end

  test "should update password with valid token" do
    post :update, id: @token, user: { password: 'newpassword', password_confirmation: 'newpassword'}

    assert users(:teacher2).reload.authenticate('newpassword')
    assert_redirected_to root_url
  end

  test "should not update password with password mismatch" do
    post :update, id: @token, user: { password: 'newpassword', password_confirmation: 'newpassword22'}

    assert_template :edit
  end

  test "should give error with old token" do
    users(:teacher2).password_reset_sent_at = Time.zone.now - 5.hours
    users(:teacher2).save

    post :update, id: @token, user: { password: 'newpassword', password_confirmation: 'newpassword'}

    assert_redirected_to new_password_reset_path
    assert_equal "Permission to change password has expired.", flash[:alert]
  end

end