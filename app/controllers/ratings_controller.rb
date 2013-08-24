class RatingsController < ApplicationController

  before_action :check_user_login
  before_action :get_nested_classroom

  def add
    params[:checkpoints].each_value do |checkpoint_hash|

      unless Rating::OPTIONS[checkpoint_hash[":score"]] == :label
        checkpoint = Checkpoint.find(checkpoint_hash[":id"])
        score = Rating::OPTIONS[checkpoint_hash[":score"]]
        session["checkpoint_#{checkpoint.id}"] = score
        rating = checkpoint.ratings.create(score: score)
      end

    end

     redirect_to classroom_tracks_path(@classroom), notice: 'Responses registered!'
  end

end
