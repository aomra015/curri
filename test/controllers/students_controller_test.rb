require "test_helper"

class StudentsControllerTest < ActionController::TestCase

  before do
    @invitation = Invitation.create(email: 'student@gmail.com', classroom: classrooms(:one))
    @params = {
      email: "misty@aomran.com",
      first_name: "misty",
      last_name: "omran-franzini",
      password: "likeskoi",
      password_confirmation: "likeskoi",
      token: @invitation.token
    }
    @login_params = {
      email: users(:new_student).email,
      password: "password123",
      token: @invitation.token
    }
  end

  test "should get claim form" do
    get :new, token: @invitation.token

    assert assigns(:user)
    assert assigns(:token)
    assert_response :success
  end

  test "should create a student with valid data" do
    assert_difference 'User.count' do
      post :create, user: @params
    end

    assert User.last.student?
    assert_redirected_to classrooms_path
  end

  test "should not create student with invalid token" do
    @params[:token] = "invalid-token"
    post :create, user: @params

    assert_equal "The invitation is no longer valid or the URL is incorrect", flash[:alert]
  end

  test "should not create student with invalid data" do
    @params[:email] = nil
    post :create, user: @params

    assert assigns(:user).errors[:email].any?
  end

  test "should get login form" do
    get :login, token: @invitation.token

    assert assigns(:token)
    assert_response :success
  end

  test "should redirect to login form if logged in" do
    cookies[:auth_token] = users(:student1).auth_token
    get :new, token: @invitation.token

    assert_redirected_to students_login_path(@invitation.token)
  end

  test "should enroll valid student to classroom" do
    post :enroll, user: @login_params

    assert_equal users(:new_student).classrole, @invitation.reload.student
    assert_redirected_to classrooms_path
  end

  test "should not add teacher to classroom" do
    @login_params[:email] = users(:teacher1).email
    post :enroll, user: @login_params

    assert_equal "You need a student account to accept the invitation.", flash[:alert]
  end

  test "should not add student with invalid token" do
    @login_params[:token] = "invalid-token"
    post :enroll, user: @login_params

    assert_equal "The invitation is no longer valid or the URL is incorrect", flash[:alert]
  end

  test "should not enroll a student twice to same classroom" do
    @login_params[:email] = users(:student1).email

    assert_no_difference 'users(:student1).classrooms.count' do
      post :enroll, user: @login_params
    end

    assert_equal false, Invitation.exists?(@invitation.id)
  end

  test "should give login errors" do
    @login_params[:password] = "wrongpassword"
    post :enroll, user: @login_params

    assert_equal "Email or password are not correct", flash[:alert]
  end
end