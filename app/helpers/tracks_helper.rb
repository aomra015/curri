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
end
