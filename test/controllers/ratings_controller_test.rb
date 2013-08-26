require 'test_helper'

class RatingsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:ahmed).id
  end

  test "should create ratings" do
    assert_difference 'Rating.count', 2 do
      post :add, classroom_id: classrooms(:one), track_id: tracks(:one), checkpoints: { checkpoint_1: { ":id" => checkpoints(:one).id, ":score" => "Somewhat Comfortable" }, checkpoint_2: { ":id" => checkpoints(:two).id, ":score" => "Don't Understand" } }
    end

    assert_redirected_to classroom_tracks_path(classrooms(:one))
  end

end
