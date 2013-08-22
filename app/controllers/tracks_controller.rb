class TracksController < ApplicationController

  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find(params[:id])
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
    @track = Track.find(params[:id])
  end

  def update
    if @track.update(track_params)
      redirect_to track_path(@track), notice: "Track has been updated"
    else
      redirect_to tracks_path
    end
  end

  def analytics
    @tracks = Track.all
    now = Time.zone.now
    @start_at = 0
    @end_at = 0

    @start_time = Rating.first.try(:created_at) || now
    @end_time = now
  end

  def scope_analytics
    now = Time.zone.now
    @start_at = params[:start_at].to_i
    @end_at = params[:end_at].to_i

    @start_time = now - @start_at*60
    @end_time = now - @end_at*60
    @tracks = Track.all
    render :analytics
  end

  private
  def track_params
    params.require(:track).permit(:name)
  end
end
