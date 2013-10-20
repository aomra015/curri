require 'test_helper'

class CheckpointTest < ActiveSupport::TestCase

  before do
    # checkpoints(:one) has two unique ratings (score of 1)
    @checkpoint = checkpoints(:one)
    @checkpoint_no_ratings = checkpoints(:noratings)
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

  test "only one rating per student counts" do
    @checkpoint_two = checkpoints(:two)

    student = students(:student1)
    first_rating = Rating.new(score: 1)
    first_rating.student = student
    first_rating.checkpoint = @checkpoint_two
    first_rating.save

    second_rating = Rating.new(score: 2)
    second_rating.student = student
    second_rating.checkpoint = @checkpoint_two
    second_rating.save

    @start = first_rating.created_at - 1
    @end = second_rating.created_at

    assert_equal 0, @checkpoint_two.ratings_count(@start, @end, 1)
    assert_equal 1, @checkpoint_two.ratings_count(@start, @end, 2)
    assert_equal 1, @checkpoint_two.ratings_count(@start, @end)
  end

  test "latest student score" do
    @checkpoint_two = checkpoints(:two)

    student = students(:student1)
    first_rating = Rating.new(score: 1)
    first_rating.student = student
    first_rating.checkpoint = @checkpoint_two
    first_rating.save

    second_rating = Rating.new(score: 2)
    second_rating.student = student
    second_rating.checkpoint = @checkpoint_two
    second_rating.save

    assert_equal "2", @checkpoint_two.latest_student_score(student)
  end
end
