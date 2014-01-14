require 'test_helper'

class CheckpointTest < ActiveSupport::TestCase

  before do
    # stubbing time
    date_in_future = Time.zone.now + 5.days
    Time.zone.expects(:now).returns(date_in_future)

    @phase = Phase.new(tracks(:one),"Realtime")
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
    student = students(:student1)
    Rating.create(score: 1, student: student, checkpoint: checkpoints(:two))
    Rating.create(score: 2, student: student, checkpoint: checkpoints(:two))

    assert_equal 2, checkpoints(:two).latest_student_score(student)
  end

  test "hasnt voted list for class with two students" do
    classroom = classrooms(:one)
    assert_equal ["all"], checkpoints(:noratings).hasnt_voted(@phase, classroom)
    assert_equal [], checkpoints(:one).hasnt_voted(@phase, classroom)
    assert_equal ['student2@school.com'], checkpoints(:onerating).hasnt_voted(@phase, classroom)
  end
end
