class CheckpointsController < ApplicationController

  before_action :authorize_teacher
  before_action :get_nested_classroom
  before_action :get_track
  before_action :get_checkpoint, only: [:edit, :update, :destroy]

  def new
    @checkpoint = Checkpoint.new
  end

  def create
    @checkpoint = @track.checkpoints.build(checkpoint_params)
    if @checkpoint.save
      redirect_to classroom_track_path(@classroom, @track), notice: "Checkpoint has been created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @checkpoint.update(checkpoint_params)
      redirect_to classroom_track_path(@classroom, @track), notice: "Checkpoint has been updated."
    else
      render :edit
    end
  end

  def destroy
    @checkpoint.destroy
    redirect_to classroom_track_path(@classroom, @track), notice: "Checkpoint has been deleted."
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

