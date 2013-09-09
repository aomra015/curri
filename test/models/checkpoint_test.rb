require 'test_helper'

class CheckpointTest < ActiveSupport::TestCase

  before do
    # fixture has two ratings each with a score of 1
    @checkpoint = checkpoints(:one)
    @checkpoint_no_ratings = checkpoints(:two)
    @start_time = @checkpoint.ratings.first.created_at - 1
    @end_time = @checkpoint.ratings.last.created_at
  end

  test "validate presence of both attributes" do
    checkpoint = Checkpoint.new(expectation: 'something')
    checkpoint.valid?
    assert checkpoint.errors[:success_criteria].any?

    checkpoint = Checkpoint.new(success_criteria: 'something else')
    checkpoint.valid?
    assert checkpoint.errors[:expectation].any?
  end

  test "overall score" do
    assert_equal 50, @checkpoint.overall_score
    assert_equal 0, @checkpoint_no_ratings.overall_score
  end

  test "ratings count" do
    assert_equal 0, @checkpoint.ratings_count(@start_time, @end_time, 0)
    assert_equal 0, @checkpoint.ratings_count(@start_time, @end_time, 2)
    assert_equal 2, @checkpoint.ratings_count(@start_time, @end_time, 1)
    assert_equal 2, @checkpoint.ratings_count(@start_time, @end_time)

    assert_equal 0, @checkpoint_no_ratings.ratings_count(@start_time, @end_time)
  end

  test "get score" do
    assert_equal 0, @checkpoint.get_score(0, @start_time, @end_time)
    assert_equal 100, @checkpoint.get_score(1, @start_time, @end_time)
    assert_equal 0, @checkpoint.get_score(2, @start_time, @end_time)

    assert_equal 0, @checkpoint_no_ratings.get_score(2, @start_time, @end_time)
  end
end
