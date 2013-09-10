require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  test "validates presence of name" do
    track = Track.new
    track.valid?
    assert track.errors[:name].any?
  end
end
