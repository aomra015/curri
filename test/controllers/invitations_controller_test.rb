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
end
