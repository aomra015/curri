class TracksController < ApplicationController

  before_action :authorize
  before_action :authorize_teacher, except: [:index, :show]
  before_action :get_nested_classroom
  before_action :get_track, only: [:show, :edit, :update, :destroy]

  def index
    @tracks = @classroom.tracks
  end

  def show
  end

  def new
    @track = Track.new
  end

  def create
    @track = @classroom.tracks.build(track_params)
    if @track.save
      redirect_to classroom_tracks_path(@classroom), notice: "Track '#{@track.name}' has been created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @track.update(track_params)
      redirect_to classroom_track_path(@classroom, @track), notice: "Track has been updated"
    else
      render :edit
    end
  end

  def destroy
    @track.destroy
    redirect_to classroom_tracks_path(@classroom)
  end

  private
  def track_params
    params.require(:track).permit(:name, :start_date, :start_time, :end_date, :end_time)
  end

  def get_track
    @track = @classroom.tracks.find(params[:id])
  end

end
