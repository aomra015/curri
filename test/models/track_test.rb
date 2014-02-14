require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  test "validates presence of name" do
    track = Track.new
    track.valid?
    assert track.errors[:name].any?
  end

  test "old tracks are not active" do
    assert_equal false, tracks(:one).active?
  end

  test "tracks without dates are not active" do
    assert_equal false, tracks(:two).active?
  end

  test "unbpulished tracks are not active" do
    assert_equal false, tracks(:three).active?
  end

  test "today's published tracks are active" do
    date = tracks(:four).start_time + 1
    Time.zone.stubs(:now).returns(date)

    assert_equal true, tracks(:four).active?
  end
end
