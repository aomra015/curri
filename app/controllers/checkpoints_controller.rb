class CheckpointsController < ApplicationController

  def index
    @checkpoints = Checkpoint.all
  end

  def show
    @checkpoint = Checkpoint.find(params[:id])
  end

  def new
    @checkpoint = Checkpoint.new
  end

  def create
    @checkpoint = Checkpoint.new(checkpoint_params)
    if @checkpoint.save
      redirect_to checkpoint_path(@checkpoint), notice: "Checkpoint has been created"
    else
      redirect_to checkpoints_path
    end
  end

  def edit
    @checkpoint = Checkpoint.find(params[:id])
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
end

