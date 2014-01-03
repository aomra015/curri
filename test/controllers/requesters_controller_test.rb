require "test_helper"

class RequestersControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:student1).id
    PrivatePub.stubs(:publish_to)
  end

  test "should get list of requesters" do
    get :index, classroom_id: classrooms(:one).id

    assert assigns(:requesters)
    assert :success
  end

  test "student should be able to toggle status" do
    patch :reset_status, classroom_id: classrooms(:one).id

    assert_equal true, invitations(:one).reload.help
  end

  test "should redirect back after status toggle" do
    @request.env['HTTP_REFERER'] = classrooms_url
    patch :reset_status, classroom_id: classrooms(:one).id

    assert_redirected_to :back
  end

  test "should redirect to default url if referer is missing" do
    patch :reset_status, classroom_id: classrooms(:one).id
    assert_redirected_to classrooms_path
  end

  test "should publish to push server" do
    PrivatePub.expects(:publish_to).once
    patch :reset_status, classroom_id: classrooms(:one).id
  end
end