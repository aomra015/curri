class Phase
  def initialize(track, phase)
    @track = track
    @phase = phase.downcase
    unless ['default','before','during','after'].include?(@phase)
      raise ArgumentError.new("Invalid phase")
    end
    @start_of_everything = track.created_at
    @end_of_everything = DateTime.now
  end

  def start_time
    if @phase == 'during'
      return merge_time(@track.start_date, @track.start_time)
    elsif @phase == 'after'
      return merge_time(@track.end_date, @track.end_time)
    else
      return @start_of_everything
    end
  end

  def end_time
    if @phase == 'before'
      return merge_time(@track.start_date, @track.start_time)
    elsif @phase == 'during'
      return merge_time(@track.end_date, @track.end_time)
    else
      return @end_of_everything
    end
  end

  def merge_time(date,time)
    DateTime.new(date.year,date.month,date.day,time.hour,time.min,time.sec)
  end
end