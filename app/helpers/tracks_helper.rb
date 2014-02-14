module TracksHelper

  def nice_time_format(track, method)
    track.send(method).strftime("%l:%M%P") if track.send(method)
  end

  def nice_date_format(track, method)
    track.send(method).strftime("%Y-%m-%d") if track.send(method)
  end

  def display_start_time(track)
    if track.start_time
      @content = content_tag(:span, "Track start: ", class: 'strong')
      @content << content_tag(:span, "#{track.start_time.strftime("%l:%M%P, %e %b ’%y")}")
    else
      content_tag(:span, "Start time not set", class: 'unpublished-text')
    end
  end

  def display_end_time(track)
    if track.end_time
      @content = content_tag(:span, "Track end: ", class: 'strong')
      @content << content_tag(:span, "#{track.end_time.strftime("%l:%M%P, %e %b ’%y")}")
    else
      content_tag(:span, "End time not set", class: 'unpublished-text')
    end
  end

  def start_stop_icons(timestatus, published)
    pubstatus = "-unpublished" unless published
    content_tag(:span, "", class: "tracks-icons #{timestatus}-icon#{pubstatus}")
  end
end
