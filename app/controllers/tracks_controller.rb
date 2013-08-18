class TracksController < ApplicationController

  def index
    @tracks = Track.all
  end

  private
  def track_params
    params.require(:track).permit(:name)
  end
end
