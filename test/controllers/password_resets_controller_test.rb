require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase

  before do
    users(:teacher1).send_password_reset
    Delayed::Worker.new.work_off
    @token = users(:teacher1).reload.password_reset_token
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should send the password reset" do
    post :create, email: users(:teacher1).email
    assert_equal users(:teacher1), assigns(:user)

    assert_equal [1, 0], Delayed::Worker.new.work_off
    assert_redirected_to login_path
  end

  test "should show password edit form" do
    get :edit, id: @token

    assert_equal users(:teacher1), assigns(:user)
    assert :success
  end

  test "should update password with valid token" do
    post :update, id: @token, user: { password: 'newpassword', password_confirmation: 'newpassword'}

    assert users(:teacher1).reload.authenticate('newpassword')
    assert_redirected_to root_url
  end

  test "should not update password with password mismatch" do
    post :update, id: @token, user: { password: 'newpassword', password_confirmation: 'newpassword22'}

    assert_template :edit
  end

  test "should give error with old token" do
    users(:teacher1).password_reset_sent_at = Time.zone.now - 5.hours
    users(:teacher1).save

    post :update, id: @token, user: { password: 'newpassword', password_confirmation: 'newpassword'}

    assert_redirected_to new_password_reset_path
    assert_equal "Permission to change password has expired.", flash[:alert]
  end

end