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

  test "should destroy invitation" do
    assert_difference 'Invitation.count', -1 do
      delete :destroy, id: invitations(:one), classroom_id: classrooms(:one)
    end
  end

end
