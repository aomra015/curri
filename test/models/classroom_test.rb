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

  test "get requesters" do
    date_in_past = Time.zone.now - 1
    @invitation1.toggle(:help).save
    @invitation1.updated_at = date_in_past
    @invitation1.save
    @invitation2.toggle(:help).save
    assert_equal @invitation1,@classroom.requesters.first
    assert_equal @invitation2,@classroom.requesters.last
    assert_equal 2, @classroom.requesters.size
  end
end
