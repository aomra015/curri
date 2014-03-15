require 'test_helper'

class StudentTest < ActiveSupport::TestCase

  test "needs_help? method" do
    student = users(:student1)
    classroom = classrooms(:one)

    assert_equal false, student.needs_help?(classroom)

    requesters(:one).toggle!(:help)
    assert_equal true, student.needs_help?(classroom)
  end

end
