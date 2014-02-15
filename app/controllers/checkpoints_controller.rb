class CheckpointsController < ApplicationController

  before_action :authorize_teacher
  before_action :get_classroom
  before_action :get_track
  before_action :get_checkpoint, only: [:edit, :update, :destroy]

  def create
    @checkpoint = @track.checkpoints.build(checkpoint_params)

    respond_to do |format|
      if @checkpoint.save
        format.json { render json: { partial: render_to_string(partial: 'checkpoint.html', locals: { checkpoint: @checkpoint }), classroom_id: @classroom.id, track_id: @track.id, checkpoint_id: @checkpoint.id }, status: :created }
      else
        format.json { render json: @checkpoint.errors, status: :unprocessable_entity }
      end
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

    respond_to do |format|
      format.json {
        render json: { id: params[:id] }
      }
      format.html {
        redirect_to classroom_track_path(@classroom, @track), notice: "Checkpoint has been deleted."
      }
    end
  end

  def sort
    params[:checkpoint].each_with_index do |id, index|
        @track.checkpoints.where(id: id).update_all(position: index+1)
      end
    render nothing: true
  end

  private
  def checkpoint_params
    params.require(:checkpoint).permit(:expectation, :success_criteria, :track_id)
  end
end

