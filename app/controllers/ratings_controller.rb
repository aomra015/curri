class RatingsController < ApplicationController

  def add
    track = Track.find(params[:track_id])

    params[:checkpoints].each_value do |checkpoint_hash|
      checkpoint = Checkpoint.find(checkpoint_hash[":id"])
      rating = checkpoint.ratings.create(score: checkpoint_hash[":score"].to_i)
    end

     redirect_to tracks_path, notice: 'Survey registered!'
  end
end
