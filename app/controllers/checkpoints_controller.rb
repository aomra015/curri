class CheckpointsController < ApplicationController

  before_action :get_track
  before_action :get_checkpoint, except: [:index, :new, :create]

  def index
    @checkpoints = @track.checkpoints.all
  end

  def show
  end

  def new
    @checkpoint = Checkpoint.new
  end

  def create
    @checkpoint = @track.checkpoints.build(checkpoint_params)
    if @checkpoint.save
      redirect_to checkpoint_path(@checkpoint), notice: "Checkpoint has been created"
    else
      redirect_to checkpoints_path
    end
  end

  def edit
  end

  def update
    if @checkpoint.update(checkpoint_params)
      redirect_to checkpoint_path(@checkpoint), notice: "Checkpoint has been updated"
    else
      redirect_to checkpoints_path
    end
  end

  private
  def checkpoint_params
    params.require(:checkpoint).permit(:expectation, :success_criteria, :track_id)
  end

  def get_track
    @track = Track.find(params[:track_id])
  end

  def get_checkpoint
    @checkpoint = @track.checkpoints.find(params[:id])
  end
end

