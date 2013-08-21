class RatingsController < ApplicationController

  def add
    params[:checkpoints].each_value do |checkpoint_hash|
      unless no_score_selected?(checkpoint_hash)
        checkpoint = Checkpoint.find(checkpoint_hash[":id"])
        score = get_score(checkpoint_hash[":score"])
        session["checkpoint_#{checkpoint.id}"] = score
        rating = checkpoint.ratings.create(score: score)
      end
    end

     redirect_to tracks_path, notice: 'Responses registered!'
  end

  private
  def no_score_selected?(checkpoint_hash)
    checkpoint_hash[":score"] == Rating::OPTIONS[0]
  end

  def get_score(score_string)
    case score_string
    when Rating::OPTIONS[1]
      score = 0
    when Rating::OPTIONS[2]
      score = 1
    when Rating::OPTIONS[3]
      score = 2
    end
    score
  end
end
