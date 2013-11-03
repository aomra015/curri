require 'test_helper'

class PhaseTest < ActiveSupport::TestCase

  def setup
    @oct1_two_am = DateTime.new(2012, 10, 1, 2, 0, 0)
    @oct10 = DateTime.new(2012, 10, 10)
    @oct15 = DateTime.new(2012, 10, 15)
    @some_four_am = DateTime.new(2002, 3, 5, 4, 0, 0)
    @some_six_am = DateTime.new(2004, 5, 6, 6, 0, 0)
    @oct10_four_am = DateTime.new(2012, 10, 10, 4, 0, 0)
    @oct15_six_am = DateTime.new(2012, 10, 15, 6, 0, 0)
    @test_track = Track.new({:created_at => @oct1_two_am, :start_date => @oct10, :start_time => @some_four_am,
      :end_date => @oct15, :end_time => @some_six_am})
    @test_phase_before = Phase.new(@test_track,"before")
    @test_phase_during = Phase.new(@test_track,"during")
    @test_phase_after = Phase.new(@test_track,"after")
    @test_phase_all = Phase.new(@test_track,"all")
  end

  def test_bad_phase_error
    assert_raises(ArgumentError) {Phase.new(@test_track,"not before")}
  end

  def test_merge_time
    assert_equal @oct15_six_am, @test_phase_during.merge_time(@oct15,@some_six_am)
  end

  def test_start_time_before
    assert_equal @oct1_two_am, @test_phase_before.start_time
  end
  def test_end_time_before
    assert_equal @oct10_four_am, @test_phase_before.end_time
  end

  def test_start_time_during
    assert_equal @oct10_four_am, @test_phase_during.start_time
  end
  def test_end_time_during
    assert_equal @oct15_six_am, @test_phase_during.end_time
  end

  def test_start_time_after
    assert_equal @oct15_six_am, @test_phase_after.start_time
  end
  def test_end_time_after
    assert_equal DateTime.now.to_time.to_i, @test_phase_after.end_time.to_time.to_i
  end

  def test_start_time_all
    assert_equal @oct1_two_am, @test_phase_all.start_time
  end
  def test_end_time_all
    assert_equal DateTime.now.to_time.to_i, @test_phase_all.end_time.to_time.to_i
  end
end