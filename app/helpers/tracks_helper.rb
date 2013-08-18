module TracksHelper

  def ratings_data
    track = Track.first
    track.checkpoints.map do |checkpoint|
      {
        checkpoint: checkpoint.content,
        class_score: checkpoint.overall_score
      }
    end
  end
end
