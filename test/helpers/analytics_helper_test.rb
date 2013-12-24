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
    assert_equal 0, ratings_count(ratingData, 0)
    assert_equal 2, ratings_count(ratingData, 1)
    assert_equal 0, ratings_count(ratingData, 2)
  end

  test "checkpoint without ratings count" do
    ratingData = @phase.ratings(checkpoints(:noratings))
    assert_equal 0, ratings_count(ratingData, 0)
    assert_equal 0, ratings_count(ratingData, 1)
    assert_equal 0, ratings_count(ratingData, 2)
  end

  test "only one rating per student counts" do
    Rating.create(score: 1, student: students(:student1), checkpoint: checkpoints(:noratings))
    Rating.create(score: 2, student: students(:student1), checkpoint: checkpoints(:noratings))

    ratingData = @phase.ratings(checkpoints(:noratings))
    assert_equal 0, ratings_count(ratingData, 1)
    assert_equal 1, ratings_count(ratingData, 2)
  end

  test "get scores" do
    ratingData = @phase.ratings(@checkpoint)
    assert_equal 0, get_score(ratingData, 0)
    assert_equal 100, get_score(ratingData, 1)
    assert_equal 0, get_score(ratingData, 2)

    emptyratingData = @phase.ratings(checkpoints(:noratings))

    assert_equal 0, get_score(emptyratingData, 2)
  end

  test "build bars" do
    ratings = @phase.ratings(@checkpoint)
    progress_bar = content_tag :div, 2, class: 'progress-bar progress-bar-warning', style: 'width: 100.0%'
    assert_equal progress_bar, render_bar(ratings, 1)
  end
end
