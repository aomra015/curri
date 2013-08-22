class TracksController < ApplicationController

  before_action :get_track, only: [:show, :edit, :update]

  def index
    @tracks = Track.all
  end

  def show
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_path(@track), notice: "Track has been created"
    else
      redirect_to tracks_path
    end
  end

  def edit
  end

  def update
    if @track.update(track_params)
      redirect_to track_path(@track), notice: "Track has been updated"
    else
      redirect_to tracks_path
    end
  end

  private
  def track_params
    params.require(:track).permit(:name)
  end
  def get_track
    @track = Track.find(params[:id])
  end
end
