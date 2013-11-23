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

    assert_difference 'Invitation.count', 2 do
      post :create, classroom_id: classrooms(:one), invitation_emails: "student@email.com, student2@gmail.com"
    end

    assert_redirected_to classroom_tracks_path(assigns(:classroom))
  end

  test "invalid email formats not accepted" do
    post :create, classroom_id: classrooms(:one), invitation_emails: "student@email.com student2@gmail.com"

    assert_template :new
    assert_equal "Invalid email format", flash[:alert]

  end

  test "should get claim form" do
    token = Invitation.create(email: 'student@gmail.com').token
    get :claim, token: token

    assert assigns(:user)
    assert assigns(:token)
    assert_response :success
  end

  test "should create a student" do
    token = Invitation.create(email: 'student@gmail.com').token
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
    token = Invitation.create(email: 'student@gmail.com').token
    post :create_student, user: {password: "likeskoi", password_confirmation: "likeskoi", token: token}

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

    post :add_student, user: {email: users(:ahmed).email, password: "password123", token: token}

    assert flash[:alert] = "You need a student account to accept the invitation."
  end

  test "should flash error with wrong token when adding students" do
    token = "badtoken"

    post :add_student, user: {email: users(:student).email, password: "password123", token: token}

    assert_equal "The invitation is no longer valid or the URL is incorrect", flash[:alert]
  end

  test "should give login errors" do
    token = Invitation.create(email: 'student@gmail.com').token

    post :add_student, user: {email: users(:student).email, password: "wrongpassword", token: token}

    assert_equal "Email or password are not correct", flash[:alert]
  end

  test "should destroy invitation" do
    assert_difference 'Invitation.count', -1 do
      delete :destroy, id: invitations(:one), classroom_id: classrooms(:one)
    end
  end

  test "student should be able to toggle status" do
    session[:user_id] = users(:student).id
    @request.env['HTTP_REFERER'] = classrooms_url
    assert_equal false, invitations(:one).help
    patch :update_status, {classroom_id: classrooms(:one).id}
    invitation = Invitation.find(invitations(:one).id)
    assert_equal true, invitation.help
    assert_redirected_to :back
  end

  test "action redirects to some default url if referer is missing" do
    session[:user_id] = users(:student).id
    patch :update_status, {classroom_id: classrooms(:one).id}
    assert_redirected_to classrooms_path
  end



end
