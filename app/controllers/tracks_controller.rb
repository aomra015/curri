class TracksController < ApplicationController

  before_action :get_classroom
  before_action :get_track, only: [:show, :edit, :update]

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
      redirect_to classroom_track_path(@classroom, @track), notice: "Track has been created"
    else
      redirect_to classroom_tracks_path(@classroom)
    end
  end

  def edit
  end

  def update
    if @track.update(track_params)
      redirect_to classroom_track_path(@classroom, @track), notice: "Track has been updated"
    else
      redirect_to classroom_tracks_path(@classroom)
    end
  end

  private
  def track_params
    params.require(:track).permit(:name)
  end

  def get_track
    @track = @classroom.tracks.find(params[:id])
  end

  def get_classroom
    @classroom = Classroom.find(params[:classroom_id])
  end

end
