require 'test_helper'

class RatingsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:ahmed).id
  end

  test "should create ratings" do
    assert_difference 'Rating.count' do
      post :create, format: 'json', classroom_id: classrooms(:one), track_id: tracks(:one), checkpoint_id: checkpoints(:one).id, value: 0
    end
    response = JSON.parse(@response.body)
    assert_equal 0, response["score"]
  end

end
