class RatingsController < ApplicationController

  before_action :check_user_login
  before_action :get_nested_classroom

  respond_to :json, :js

  def create
    score = params[:value].to_i

    if !Rating::OPTIONS[score]
      head 422
    else
      @checkpoint = Checkpoint.find(params[:checkpoint_id])

      session["checkpoint_#{@checkpoint.id}"] = score
      @rating = @checkpoint.ratings.create(score: score)

      respond_with @rating, location: nil
    end
  end

end
