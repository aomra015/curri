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

  def score_count(track,score)
    ratings = current_user.classrole.track_ratings(track)
    count = 0
    if ratings.any?
      ratings.each do |rating|
        count += 1 if rating.score == score
      end
    end
    percent = count * 100.0 / track.checkpoints.length
    { count: count, percent: percent }
  end

  def no_scores(track)
    track_ratings = current_user.classrole.track_ratings(track)
    count = track.checkpoints.length - track_ratings.length
    percent = count * 100.0 / track.checkpoints.length
    { count: count, percent: percent }
  end
end
