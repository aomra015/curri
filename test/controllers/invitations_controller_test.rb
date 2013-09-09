require "test_helper"

class InvitationsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:ahmed).id
  end

  test "should get invitation form" do
    get :new, classroom_id: classrooms(:one).id

    assert assigns(:invitation)
    assert assigns(:invitations)
    assert_response :success
  end

  test "should get list of invitees" do
    get :new, classroom_id: classrooms(:one).id

    assert assigns(:invitation)

    assert_response :success
  end

  test "create invitation" do

    assert_difference 'Invitation.count' do
      post :create, classroom_id: classrooms(:one), invitation: {email: "student@email.com"}
    end

    assert_redirected_to classroom_tracks_path(assigns(:classroom))
  end

  test "should get claim form" do
    token = Invitation.create.token
    get :claim, token: token

    assert assigns(:user)
    assert assigns(:token)
    assert_response :success
  end

  test "should create a student" do
    token = Invitation.create.token
    assert_difference 'User.count' do
      post :create_student, user: {email: "misty@aomran.com", password: "likeskoi", password_confirmation: "likeskoi", token: token}
    end

    student = User.find(session[:user_id])

    assert_equal 'Student', student.classrole_type, 'Default classroom not created for new teacher'

    assert_redirected_to classrooms_path
  end

  test "should flash error with wrong token when creating students" do
    token = "badtoken"

    post :create_student, user: {email: "misty@aomran.com", password: "likeskoi", password_confirmation: "likeskoi", token: token}

    assert_equal "The invitation is no longer valid or the URL is incorrect", flash[:alert]
  end

  test "should give validation errors when creating students" do
    token = Invitation.create.token
    post :create_student, user: {password: "likeskoi", password_confirmation: "likeskoi", token: token}

    assert assigns(:user).errors[:email].any?
  end

  test "should get login form" do
    token = Invitation.create.token
    get :login, token: token

    assert assigns(:token)
    assert_response :success
  end

  test "should not add teacher to classroom" do
    token = Invitation.create.token

    post :add_student, user: {email: users(:ahmed).email, password: "password123", token: token}

    assert flash[:alert] = "You need a student account to accept the invitation."
  end

  test "should flash error with wrong token when adding students" do
    token = "badtoken"

    post :add_student, user: {email: users(:student).email, password: "password123", token: token}

    assert_equal "The invitation is no longer valid or the URL is incorrect", flash[:alert]
  end

  test "should give login errors" do
    token = Invitation.create.token

    post :add_student, user: {email: users(:student).email, password: "wrongpassword", token: token}

    assert_equal "Email or password are not correct", flash[:alert]
  end


end
