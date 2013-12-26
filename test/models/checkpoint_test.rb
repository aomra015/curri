require 'test_helper'

class CheckpointTest < ActiveSupport::TestCase

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

  test "validate presence of both attributes" do
    checkpoint = Checkpoint.new(expectation: 'something')
    checkpoint.valid?
    assert checkpoint.errors[:success_criteria].any?

    checkpoint = Checkpoint.new(success_criteria: 'something else')
    checkpoint.valid?
    assert checkpoint.errors[:expectation].any?
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

  test "hasnt voted method for class with two students" do
    assert_equal ["all"], checkpoints(:noratings).hasnt_voted(@phase)
    assert_equal [], checkpoints(:one).hasnt_voted(@phase)
    assert_equal ['student2@school.com'], checkpoints(:onerating).hasnt_voted(@phase)
  end
end
