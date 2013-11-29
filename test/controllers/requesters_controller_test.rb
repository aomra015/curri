require "test_helper"

class RequestersControllerTest < ActionController::TestCase
  test "student should be able to toggle status" do
    PrivatePub.stubs(:publish_to)
    session[:user_id] = users(:student).id
    @request.env['HTTP_REFERER'] = classrooms_url
    assert_equal false, invitations(:one).help
    patch :reset_status, {classroom_id: classrooms(:one).id}
    invitation = Invitation.find(invitations(:one).id)
    assert_equal true, invitation.help
    assert_redirected_to :back
  end

  test "action redirects to some default url if referer is missing" do
    PrivatePub.stubs(:publish_to)
    session[:user_id] = users(:student).id
    patch :reset_status, {classroom_id: classrooms(:one).id}
    assert_redirected_to classrooms_path
  end
end