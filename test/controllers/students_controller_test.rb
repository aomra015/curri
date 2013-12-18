require "test_helper"

class StudentsControllerTest < ActionController::TestCase

  test "should get claim form" do
    token = Invitation.create(email: 'student@gmail.com').token
    get :new, token: token

    assert assigns(:user)
    assert assigns(:token)
    assert_response :success
  end

  test "should create a student" do
    token = Invitation.create(email: 'student@gmail.com').token
    assert_difference 'User.count' do
      post :create, user: {email: "misty@aomran.com", first_name: "misty", last_name: "omran-franzini", password: "likeskoi", password_confirmation: "likeskoi", token: token}
    end

    student = User.find(session[:user_id])

    assert_equal 'Student', student.classrole_type, 'Default classroom not created for new teacher'

    assert_redirected_to classrooms_path
  end

  test "should flash error with wrong token when creating students" do
    token = "badtoken"

    post :create, user: {email: "misty@aomran.com", password: "likeskoi", password_confirmation: "likeskoi", token: token}

    assert_equal "The invitation is no longer valid or the URL is incorrect", flash[:alert]
  end

  test "should give validation errors when creating students" do
    token = Invitation.create(email: 'student@gmail.com').token
    post :create, user: {password: "likeskoi", password_confirmation: "likeskoi", token: token}

    assert assigns(:user).errors[:email].any?
  end

  test "should get login form" do
    token = Invitation.create(email: 'student@gmail.com').token
    get :login, token: token

    assert assigns(:token)
    assert_response :success
  end

  test "should not add teacher to classroom" do
    token = Invitation.create(email: 'student@gmail.com').token

    post :enroll, user: {email: users(:ahmed).email, password: "password123", token: token}

    assert flash[:alert] = "You need a student account to accept the invitation."
  end

  test "should flash error with wrong token when adding students" do
    token = "badtoken"

    post :enroll, user: {email: users(:student).email, password: "password123", token: token}

    assert_equal "The invitation is no longer valid or the URL is incorrect", flash[:alert]
  end

  test "should give login errors" do
    token = Invitation.create(email: 'student@gmail.com').token

    post :enroll, user: {email: users(:student).email, password: "wrongpassword", token: token}

    assert_equal "Email or password are not correct", flash[:alert]
  end
end