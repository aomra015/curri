class RatingsController < ApplicationController

  def add
    params[:checkpoints].each_value do |checkpoint_hash|
      unless no_score_selected?(checkpoint_hash)
        checkpoint = Checkpoint.find(checkpoint_hash[":id"])
        score = get_score(checkpoint_hash[":score"])
        rating = checkpoint.ratings.create(score: score)
      end
    end

     redirect_to tracks_path, notice: 'Responses registered!'
  end

  private
  def no_score_selected?(checkpoint_hash)
    checkpoint_hash[":score"] == "Rate your understanding"
  end

  def get_score(score_string)
    case score_string
    when "Don't Understand"
      score = 0
    when "Feel Comfortable"
      score = 1
    when "Totally Understand"
      score = 2
    end
    score
  end
end
