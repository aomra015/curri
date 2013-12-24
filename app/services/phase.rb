class Phase
  attr_reader :phase_text
  PHASES = ['All','Before','During','After']

  def initialize(track, phase_text)
    @track = track
    @phase_text = phase_text
    unless PHASES.include?(@phase_text)
      raise ArgumentError.new("Invalid phase")
    end
    @start_of_everything = track.created_at
    @end_of_everything = Time.zone.now
  end

  def start_time
    if @phase_text == 'During'
      return @track.start_time
    elsif @phase_text == 'After'
      return @track.end_time
    else
      return @start_of_everything
    end
  end

  def end_time
    if @phase_text == 'Before'
      return @track.start_time
    elsif @phase_text == 'During'
      return @track.end_time
    else
      return @end_of_everything
    end
  end

  def ratings(checkpoint)
    checkpoint.ratings.where({ created_at: start_time..end_time }).select("DISTINCT ON (student_id) * ").order("student_id, created_at DESC")
  end

end