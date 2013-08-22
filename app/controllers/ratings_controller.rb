class RatingsController < ApplicationController

  def add
    params[:checkpoints].each_value do |checkpoint_hash|

      unless Rating::OPTIONS[checkpoint_hash[":score"]] == :label
        checkpoint = Checkpoint.find(checkpoint_hash[":id"])
        score = Rating::OPTIONS[checkpoint_hash[":score"]]
        session["checkpoint_#{checkpoint.id}"] = score
        rating = checkpoint.ratings.create(score: score)
      end

    end

     redirect_to tracks_path, notice: 'Responses registered!'
  end
end
