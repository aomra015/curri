require 'test_helper'

class TracksHelperTest < ActionView::TestCase
  before do
    # track one has 4 checkpoints. Student1 has rated 2 of them. Student 2 has rated 1. All scores are 1.
    @student = users(:student).classrole
    @track = tracks(:one)
    stubs(:current_user).returns(users(:student))
  end

  test "student ratings count" do
    assert_equal({ :count => 0, :percent => 0.0 } , score_count(@track,0))
    assert_equal({ :count => 2, :percent => 50.0 } , score_count(@track,1))
    assert_equal({ :count => 0, :percent => 0.0 } , score_count(@track,2))
  end

  test "only one rating per student per checkpoint counts" do
    Rating.create(score: 2, student: @student, checkpoint: checkpoints(:one))
    assert_equal({ :count => 1, :percent => 25.0 } , score_count(@track,1))
    assert_equal({ :count => 1, :percent => 25.0 } , score_count(@track,2))
  end

  test "empty bar scores count" do
    assert_equal({ :count => 2, :percent => 50.0 } , no_scores(@track))
  end
end
