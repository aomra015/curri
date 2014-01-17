module TracksHelper

  def nice_time_format(track, method)
    track.send(method).strftime("%l:%M%P") if track.send(method)
  end

  def nice_date_format(track, method)
    track.send(method).strftime("%Y-%m-%d") if track.send(method)
  end

  def display_start_end_times(track)
    if track.phasing?
      start_string = track.start_time.strftime("%l:%M%P, %e %b %y")
      end_string = track.end_time.strftime("%l:%M%P, %e %b %y")
      "Track start/end: #{start_string} to #{end_string}"
    end
  end

  def display_start_time(track)
    if track.start_time
      "Track start: #{track.start_time.strftime("%l:%M%P, %e %b %y")}"
    else
      "no start time defined"
    end
  end

  def display_end_time(track)
    if track.end_time
      "Track end: #{track.end_time.strftime("%l:%M%P, %e %b %y")}"
    else
      "no end time defined"
    end
  end
end
