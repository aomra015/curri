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
      @content = content_tag(:div) do
        @content = content_tag(:span, "Track Start: ", class: 'strong')
        @content << content_tag(:span, "#{start_string}")
      end
      @content << content_tag(:div) do
        @content = content_tag(:span, "Track End: ", class: 'strong')
        @content << content_tag(:span, "#{end_string}")  
      end
    end
  end

  def display_start_time(track)
    if track.start_time
      content_tag(:span, "Track start: #{track.start_time.strftime("%l:%M%P, %e %b %y")}")
    else
      content_tag(:span, "Start time not set", class: 'unpublished-text')
    end
  end

  def display_end_time(track)
    if track.end_time
      content_tag(:span, "Track end: #{track.end_time.strftime("%l:%M%P, %e %b %y")}")
    else
      content_tag(:span, "End time not set", class: 'unpublished-text')
    end
  end

  def start_stop_icons(timestatus, published)
    pubstatus = "-unpublished" unless published
    content_tag(:span, "", class: "tracks-icons #{timestatus}-icon#{pubstatus}")
  end
end
