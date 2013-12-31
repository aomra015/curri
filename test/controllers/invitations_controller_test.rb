require "test_helper"

class InvitationsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:ahmed).id
  end

  test "should get invitation form & list of invitees" do
    get :new, classroom_id: classrooms(:one).id

    assert assigns(:invitation) && assigns(:invitations)
    assert_response :success
  end

  test "should create invitations" do

    assert_difference 'Invitation.count', 2 do
      post :create, classroom_id: classrooms(:one), invitation_emails: "student@email.com, student2@gmail.com"
    end

    assert_redirected_to new_classroom_invitation_path(assigns(:classroom))
  end

  test "should give error with invalid email formats" do
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
