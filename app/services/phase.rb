class Phase
  attr_reader :state
  PHASES = ['Realtime','Before','During','After']

  def initialize(track, state)
    @track = track
    @state = state
    unless PHASES.include?(@state)
      raise ArgumentError.new("Invalid phase")
    end
    @start_of_everything = track.created_at
    @end_of_everything = Time.zone.now
  end

  def start_time
    if @state == 'During'
      return @track.start_time
    elsif @state == 'After'
      return @track.end_time
    else
      return @start_of_everything
    end
  end

  def end_time
    if @state == 'Before'
      return @track.start_time
    elsif @state == 'During'
      return @track.end_time
    else
      return @end_of_everything
    end
  end

  def ratings(checkpoint)
    checkpoint.ratings.where({ created_at: start_time..end_time }).distinct_by_student
  end

end