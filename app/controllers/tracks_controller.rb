class TracksController < ApplicationController

  before_action :authorize_teacher, except: [:index, :show]
  before_action :get_classroom
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
    parse_date_time
    if @track.save
      redirect_to classroom_tracks_path(@classroom), notice: "Track '#{@track.name}' has been created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    parse_date_time
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
    params.require(:track).permit(:name)
  end

  def get_track
    @track = @classroom.tracks.find(params[:id])
  end

  def parse_date_time
    @track.start_time = Time.zone.parse("#{params[:track][:start_date]} #{params[:track][:start_time]}")
    @track.end_time = Time.zone.parse("#{params[:track][:end_date]} #{params[:track][:end_time]}")
  end

end
