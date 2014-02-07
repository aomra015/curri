namespace :curri do
  desc "Add position value to older checkpoints"
  task checkpoint_positions: :environment do
    Checkpoint.all.find_each do |checkpoint|
      checkpoint.position = checkpoint.id
      checkpoint.save
    end
  end

end
