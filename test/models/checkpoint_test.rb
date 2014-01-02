require 'test_helper'

class CheckpointTest < ActiveSupport::TestCase

  before do
    # checkpoints(:one) has two unique ratings (score of 1)
    @checkpoint = checkpoints(:one)

    # stubbing time
    date_in_future = Time.zone.now + 1
    Time.zone.expects(:now).returns(date_in_future)

    @phase = Phase.new(@checkpoint.track,"Realtime")
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
    Rating.create(score: 1, student: students(:student1), checkpoint: checkpoints(:two))
    Rating.create(score: 2, student: students(:student1), checkpoint: checkpoints(:two))

    assert_equal 2, checkpoints(:two).latest_student_score(students(:student1))
  end

  test "hasnt voted list for class with two students" do
    assert_equal ["all"], checkpoints(:noratings).hasnt_voted(@phase)
    assert_equal [], checkpoints(:one).hasnt_voted(@phase)
    assert_equal ['student2@school.com'], checkpoints(:onerating).hasnt_voted(@phase)
  end
end
