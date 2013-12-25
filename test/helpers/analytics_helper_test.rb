require 'test_helper'

class AnalyticsHelperTest < ActionView::TestCase

  before do
    # checkpoints(:one) has two unique ratings (score of 1)
    @checkpoint = checkpoints(:one)

    # stubbing time
    date_in_future = Time.zone.now + 1
    date_in_past = @checkpoint.track.created_at - 1
    Time.zone.expects(:now).returns(date_in_future)
    @checkpoint.track.created_at = date_in_past

    @phase = Phase.new(@checkpoint.track,"All")
  end

  test "checkpoint with ratings count" do
    ratingData = @phase.ratings(@checkpoint)
    assert_equal({ :count => 0, :percent => 0.0 }, ratings_count(ratingData, 0, @checkpoint))
    assert_equal({ :count => 2, :percent => 100.0 }, ratings_count(ratingData, 1, @checkpoint))
    assert_equal({ :count => 0, :percent => 0.0 }, ratings_count(ratingData, 2, @checkpoint))
  end

  test "checkpoint without ratings count" do
    ratingData = @phase.ratings(checkpoints(:noratings))
    assert_equal({ :count => 0, :percent => 0.0 }, ratings_count(ratingData, 0, checkpoints(:noratings)))
    assert_equal({ :count => 0, :percent => 0.0 }, ratings_count(ratingData, 1, checkpoints(:noratings)))
    assert_equal({ :count => 0, :percent => 0.0 }, ratings_count(ratingData, 2, checkpoints(:noratings)))
  end

  test "only one rating per student counts" do
    Rating.create(score: 1, student: students(:student1), checkpoint: checkpoints(:noratings))
    Rating.create(score: 2, student: students(:student1), checkpoint: checkpoints(:noratings))

    ratingData = @phase.ratings(checkpoints(:noratings))
    assert_equal({ :count => 0, :percent => 0.0 }, ratings_count(ratingData, 1, checkpoints(:noratings)))
    assert_equal({ :count => 1, :percent => 50.0 }, ratings_count(ratingData, 2, checkpoints(:noratings)))
  end

  test "get scores" do
    @checkpoint = checkpoints(:onerating)
    ratingData = @phase.ratings(@checkpoint)
    assert_equal({ :count => 0, :percent => 0.0 }, ratings_count(ratingData, 0, @checkpoint))
    assert_equal({ :count => 1, :percent => 50.0 }, ratings_count(ratingData, 1, @checkpoint))
    assert_equal({ :count => 0, :percent => 0.0 }, ratings_count(ratingData, 2, @checkpoint))

    emptyratingData = @phase.ratings(checkpoints(:noratings))
    assert_equal({ :count => 0, :percent => 0.0 }, ratings_count(emptyratingData, 2, checkpoints(:noratings)))
  end

  test "empty bar ratings count" do
    ratingData = @phase.ratings(checkpoints(:noratings))
    assert_equal({ :count => 2, :percent => 100.0 } , no_ratings(ratingData, checkpoints(:noratings)))

    ratingData = @phase.ratings(@checkpoint)
    assert_equal({ :count => 0, :percent => 0.0 } , no_ratings(ratingData, @checkpoint))
  end

  test "build bars" do
    ratings = @phase.ratings(@checkpoint)
    progress_bar = content_tag :div, 2, class: 'progress-bar progress-bar-warning', style: 'width: 100.0%'
    assert_equal progress_bar, render_bar(ratings_count(ratings, 1, @checkpoint), 1)
  end

  test "hasnt voted list for class with two students" do
    assert_equal ["all"], hasnt_voted(@phase.ratings(checkpoints(:noratings)))
    assert_equal [], hasnt_voted(@phase.ratings(@checkpoint))
    assert_equal ['student2@school.com'], hasnt_voted(@phase.ratings(checkpoints(:onerating)))
  end
end
