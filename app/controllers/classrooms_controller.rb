class ClassroomsController < ApplicationController

  before_action :authorize_teacher, except: [:index, :show]
  before_action :get_classroom, only: [:edit, :update, :destroy]

  def index
    @classrooms = @current_user.classrooms
  end

  def new
    @classroom = Classroom.new
  end

  def create
    @classroom = @current_user.classrooms.build(classroom_params)
    if @classroom.save
      redirect_to classrooms_path, notice: "Your new classroom '#{@classroom.name}' has been created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @classroom.update(classroom_params)
      redirect_to classroom_tracks_path(@classroom), notice: "Classroom has been updated."
    else
      render :edit
    end
  end

  def destroy
    @classroom.destroy
    redirect_to classrooms_path, notice: "Classroom has been deleted."
  end

  private
  def classroom_params
    params.require(:classroom).permit(:name)
  end
end
