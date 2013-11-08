require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  before do
    # track one has 4 checkpoints. Student1 has rated 2 of them. Student 2 has rated 1. All scores are 1.
    @student1 = students(:student1)
    @student2 = students(:student2)
    @track = tracks(:one)
  end

  test "student ratings count" do
    assert_equal 2, @student1.student_ratings_count(@track)
    assert_equal 1, @student2.student_ratings_count(@track)
    assert_equal 0, @student1.student_ratings_count(@track,0)
    assert_equal 2, @student1.student_ratings_count(@track,1)
    assert_equal 0, @student1.student_ratings_count(@track,2)
  end

  test "only one rating per student per checkpoint counts" do

    new_rating = Rating.new(score: 2)
    new_rating.student = @student1
    new_rating.checkpoint = checkpoints(:one)
    new_rating.save

    assert_equal 2, @student1.student_ratings_count(@track)
    assert_equal 1, @student1.student_ratings_count(@track,1)
    assert_equal 1, @student1.student_ratings_count(@track,2)
  end
end
