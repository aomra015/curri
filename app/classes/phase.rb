class Phase
  attr_reader :phase_text

  def initialize(track, phase_text)
    @track = track
    @phase_text = phase_text.downcase
    unless ['all','before','during','after'].include?(@phase_text)
      raise ArgumentError.new("Invalid phase")
    end
    @start_of_everything = track.created_at
    @end_of_everything = Time.zone.now
  end

  def start_time
    if @phase_text == 'during'
      return @track.start_time
    elsif @phase_text == 'after'
      return @track.end_time
    else
      return @start_of_everything
    end
  end

  def end_time
    if @phase_text == 'before'
      return @track.start_time
    elsif @phase_text == 'during'
      return @track.end_time
    else
      return @end_of_everything
    end
  end

end