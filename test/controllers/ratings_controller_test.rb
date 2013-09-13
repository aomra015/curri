require 'test_helper'

class RatingsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:student).id
  end

  test "should create ratings with html request" do
    assert_difference 'Rating.count' do
      post :create, classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint_id: checkpoints(:one).id, value: 0
    end
    assert_redirected_to classroom_track_path(classrooms(:one), tracks(:one))
  end

  test "should create ratings with js request" do
    PrivatePub.stubs(:publish_to)

    assert_difference 'Rating.count' do
      post :create, format: 'js', classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint_id: checkpoints(:one).id, value: 0
    end

    response = JSON.parse(@response.body)
    assert_equal 0, response["score"]
  end

  test "only students should be able to rate checkpoints" do
    session[:user_id] = users(:ahmed).id
    post :create, classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint_id: checkpoints(:one).id, value: 0

    assert_redirected_to classroom_track_path(classrooms(:one), tracks(:one))
    assert_equal "Only students can rate", flash[:alert]
  end

end
