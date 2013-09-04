class CheckpointsController < ApplicationController

  before_action :authorize
  before_action :get_nested_classroom
  before_action :get_track
  before_action :get_checkpoint, except: [:index, :new, :create]

  def index
    @checkpoints = @track.checkpoints
  end

  def show
  end

  def new
    @checkpoint = Checkpoint.new
  end

  def create
    @checkpoint = @track.checkpoints.build(checkpoint_params)
    if @checkpoint.save
      redirect_to classroom_track_checkpoint_path(@classroom, @track, @checkpoint), notice: "Checkpoint has been created"
    else
      redirect_to classroom_track_checkpoints_path(@classroom, @track)
    end
  end

  def edit
  end

  def update
    if @checkpoint.update(checkpoint_params)
      redirect_to classroom_track_checkpoint_path(@classroom, @track, @checkpoint), notice: "Checkpoint has been updated"
    else
      redirect_to classroom_track_checkpoints_path(@classroom, @track)
    end
  end

  private
  def checkpoint_params
    params.require(:checkpoint).permit(:expectation, :success_criteria, :track_id)
  end

  def get_track
    @track = @classroom.tracks.find(params[:track_id])
  end

  def get_checkpoint
    @checkpoint = @track.checkpoints.find(params[:id])
  end
end

