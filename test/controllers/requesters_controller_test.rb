require "test_helper"

class RequestersControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:student1).id
    Pusher.stubs(:trigger)
  end

  test "should get list of requesters" do
    get :index, classroom_id: classrooms(:one).id

    assert assigns(:requesters)
    assert :success
  end

  test "student should be able to join queue" do
    patch :update, classroom_id: classrooms(:one).id, id: invitations(:one).id

    assert_equal true, invitations(:one).reload.help
  end

  test "student should be able to leave queue" do
    invitations(:one).help = true # Student joins Queue
    invitations(:one).save

    patch :update, classroom_id: classrooms(:one).id, id: invitations(:one).id

    assert_equal false, invitations(:one).reload.help
  end

  test "should redirect back after joining/leaving queue" do
    @request.env['HTTP_REFERER'] = classrooms_url
    patch :update, classroom_id: classrooms(:one).id, id: invitations(:one).id

    assert_redirected_to :back
  end

  test "should redirect to default url if referer is missing" do
    patch :update, classroom_id: classrooms(:one).id, id: invitations(:one).id
    assert_redirected_to classrooms_path
  end

  test "should publish to push server" do
    Pusher.expects(:trigger).once
    patch :update, classroom_id: classrooms(:one).id, id: invitations(:one).id
  end

  test "teacher should be able to remove requester from queue" do
    invitations(:one).help = true # Student joins Queue
    invitations(:one).save

    session[:user_id] = users(:teacher1).id
    patch :remove, classroom_id: classrooms(:one).id, id: invitations(:one).id

    assert_equal false, invitations(:one).reload.help
  end
end