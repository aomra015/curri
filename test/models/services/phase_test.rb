require 'test_helper'

class PhaseTest < ActiveSupport::TestCase

  def setup
    @oct1_two_am = Time.zone.parse("2012-10-1 2am")
    @oct10_four_am = Time.zone.parse("2012-10-10 4am")
    @oct15_six_am = Time.zone.parse("2012-10-15 6am")
    @duringDate = Time.zone.parse("2012-10-12 6am")
    @beforeDate = Time.zone.parse("2012-10-3 6am")
    @test_track = Track.new({:created_at => @oct1_two_am, :start_time => @oct10_four_am, :end_time => @oct15_six_am})
    @test_phase_before = Phase.new(@test_track,"Before")
    @test_phase_during = Phase.new(@test_track,"During")
    @test_phase_after = Phase.new(@test_track,"After")
    @test_phase_all = Phase.new(@test_track,"Realtime")
  end

  def test_bad_phase_error
    assert_raises(ArgumentError) {Phase.new(@test_track,"not before")}
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
    assert_equal Time.zone.now.to_time.to_i, @test_phase_after.end_time.to_time.to_i
  end

  def test_start_time_all
    assert_equal @oct1_two_am, @test_phase_all.start_time
  end
  def test_end_time_all
    assert_equal Time.zone.now.to_time.to_i, @test_phase_all.end_time.to_time.to_i
  end

  def test_phase_scopes_ratings
    phase = Phase.new(tracks(:one), "Realtime")
    assert_equal 2, phase.ratings(checkpoints(:one)).size
  end

  def test_before_phase_scopes_ratings
    @test_track.checkpoints << checkpoints(:one)
    assert_equal 0, @test_phase_before.ratings(checkpoints(:one)).size

    checkpoints(:one).ratings << Rating.new(score: 1, student: students(:student1), created_at: @beforeDate)
    assert_equal 1, @test_phase_before.ratings(checkpoints(:one)).size
  end

  def test_during_phase_scopes_ratings
    @test_track.checkpoints << checkpoints(:one)
    assert_equal 0, @test_phase_during.ratings(checkpoints(:one)).size

    checkpoints(:one).ratings << Rating.new(score: 1, student: students(:student1), created_at: @duringDate)
    assert_equal 1, @test_phase_during.ratings(checkpoints(:one)).size
  end

  def test_after_phase_scopes_ratings
    @test_track.checkpoints << checkpoints(:one)
    assert_equal 2, @test_phase_after.ratings(checkpoints(:one)).size

    checkpoints(:one).ratings << Rating.new(score: 1, student: students(:student1), created_at: @duringDate)
    assert_equal 2, @test_phase_after.ratings(checkpoints(:one)).size
  end
end