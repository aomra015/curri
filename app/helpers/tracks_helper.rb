module TracksHelper

  # def ratings_data
  #   track = Track.first
  #   track.checkpoints.map do |checkpoint|
  #     {
  #       checkpoint: checkpoint.expectation,
  #       class_score: checkpoint.overall_score
  #     }
  #   end
  # end

  def nice_time_format(track, method)
    track.send(method).to_s(:time) if track.send(method)
  end

  def display_start_end_times(track)
    if track.phasing?
      #start_string = track.start_date.to_formatted_s(:rfc822) + " "
      #start_string += track.start_time.strftime("%l:%M%P")
      #end_string = track.end_date.to_formatted_s(:rfc822) + " "
      #end_string += track.end_time.strftime("%l:%M%P")
      start_string = track.start_date.to_s + " "
      start_string += track.start_time.to_s
      end_string = track.end_date.to_s + " "
      end_string += track.end_time.to_s
      "Track start/end: #{start_string} to #{end_string}"
    end
  end
end
