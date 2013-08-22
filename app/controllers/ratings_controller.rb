class RatingsController < ApplicationController

  before_action :get_classroom

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

  private
  def get_classroom
    @classroom = Classroom.find(params[:classroom_id])
  end
end
