require "test_helper"

class RequestersControllerTest < ActionController::TestCase

  before do
    cookies[:auth_token] = users(:student1).auth_token
    Pusher.stubs(:trigger)
  end

  test "should get list of requesters" do
    cookies[:auth_token] = users(:teacher1).auth_token
    get :index, classroom_id: classrooms(:one).id

    assert assigns(:requesters)
    assert :success
  end

  test "student should be able to join queue" do
    patch :update, classroom_id: classrooms(:one).id, id: requesters(:one).id

    assert_equal true, requesters(:one).reload.help
  end

  test "student should be able to leave queue" do
    requesters(:one).help = true # Student joins Queue
    requesters(:one).save

    patch :update, classroom_id: classrooms(:one).id, id: requesters(:one).id

    assert_equal false, requesters(:one).reload.help
  end

  test "should redirect back after joining/leaving queue" do
    @request.env['HTTP_REFERER'] = classrooms_url
    patch :update, classroom_id: classrooms(:one).id, id: requesters(:one).id

    assert_redirected_to :back
  end

  test "should redirect to default url if referer is missing" do
    patch :update, classroom_id: classrooms(:one).id, id: requesters(:one).id
    assert_redirected_to classrooms_path
  end

  test "should publish to push server" do
    Pusher.expects(:trigger).once
    patch :update, classroom_id: classrooms(:one).id, id: requesters(:one).id
  end

  test "teacher should be able to remove requester from queue" do
    requesters(:one).help = true # Student joins Queue
    requesters(:one).save

    cookies[:auth_token] = users(:teacher1).auth_token
    patch :remove, classroom_id: classrooms(:one).id, id: requesters(:one).id

    assert_equal false, requesters(:one).reload.help
  end
end