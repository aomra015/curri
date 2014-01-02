require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase
  before do
    @classroom = classrooms(:one)
    @classroom_no_requesters = classrooms(:two)
    @invitation1 = invitations(:one)
    @invitation2 = invitations(:three)
  end

  test "validates presence of name" do
    classroom = Classroom.new
    classroom.valid?
    assert classroom.errors[:name].any?
  end

  test "requesters list" do
    @invitation1.toggle!(:help)
    @invitation2.toggle!(:help)

    assert_equal 2, @classroom.requesters.size
  end

  test "requesters in ASC order by updated_at" do
    # First Request
    @invitation1.toggle!(:help)
    # Newer Request
    @invitation2.toggle(:help)
    @invitation2.updated_at = Time.zone.now - 1
    @invitation2.save

    assert_equal @invitation2,@classroom.requesters.first
    assert_equal @invitation1,@classroom.requesters.last
  end
end
