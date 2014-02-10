namespace :curri do
  desc "Add position value to older checkpoints"
  task checkpoint_positions: :environment do
    Checkpoint.all.find_each do |checkpoint|
      checkpoint.position = checkpoint.id
      checkpoint.save
    end
  end

  desc "Add position value to older tracks"
  task track_positions: :environment do
    Track.all.find_each do |track|
      track.position = track.id
      track.save
    end
  end

end
