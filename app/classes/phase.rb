class Phase
  def initialize(track, phase)
    @track = track
    @phase = phase.downcase
    @start_of_everything = track.created_at
    @end_of_everything = DateTime.now
    #Time.zone.now
  end

  def start_time
    if @phase == 'before' || @phase == 'default'
      return @start_of_everything
    elsif @phase == 'during'
      return merge_time(@track.start_date, @track.start_time)
    elsif @phase == 'after'
      return merge_time(@track.end_date, @track.end_time)
    else
      raise ArgumentError.new("Invalid phase")
    end
  end

  def end_time
    if @phase == 'before'
      return merge_time(@track.start_date, @track.start_time)
    elsif @phase == 'during'
      return merge_time(@track.end_date, @track.end_time)
    elsif @phase == 'after' || @phase == 'default'
      return @end_of_everything
    else
      raise ArgumentError.new("Invalid phase")
    end
  end

  def merge_time(date,time)
    DateTime.new(date.year,date.month,date.day,time.hour,time.min,time.sec)
  end
end