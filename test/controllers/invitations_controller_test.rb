require "test_helper"

class InvitationsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:ahmed).id
  end

  test "should get invitation form" do
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
      post :create_student, user: {username: "misty", email: "misty@aomran.com", password: "likeskoi", password_confirmation: "likeskoi", token: token}
    end

    student = User.find(session[:user_id])

    assert_equal 'Student', student.classrole_type, 'Default classroom not created for new teacher'

    assert_redirected_to classrooms_path
  end

end
