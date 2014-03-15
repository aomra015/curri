require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase
  before do
    @classroom = classrooms(:one)
    @classroom_no_requesters = classrooms(:two)
    @requester1 = requesters(:one)
    @requester2 = requesters(:two)
  end

  test "validates presence of name" do
    classroom = Classroom.new
    classroom.valid?
    assert classroom.errors[:name].any?
  end

  test "requesters list" do
    @requester1.toggle!(:help)
    @requester2.toggle!(:help)

    assert_equal 2, @classroom.requesters.size
  end

  test "requesters in ASC order by updated_at" do
    # First Request
    @requester1.toggle!(:help)
    # Newer Request
    @requester2.toggle(:help)
    @requester2.updated_at = Time.zone.now - 1
    @requester2.save

    assert_equal @requester2, @classroom.requesters.first
    assert_equal @requester1, @classroom.requesters.last
  end
end
