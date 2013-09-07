class ClassroomsController < ApplicationController

  before_action :authorize
  before_action :authorize_teacher, except: [:index, :show]
  before_action :get_classroom, only: [:show, :edit, :update]

  def index
    @classrooms = @current_user.classrooms
  end

  def show
  end

  def new
    @classroom = Classroom.new
  end

  def create
    @classroom = @current_user.classrooms.build(classroom_params)
    if @classroom.save
      redirect_to classrooms_path, notice: "Your new classroom '#{@classroom.name}' has been created"
    else
      redirect_to classrooms_path, notice: "there was an error with your classroom creation"
    end
  end

  def edit
  end

  def update
    if @classroom.update(classroom_params)
      redirect_to classroom_path(@classroom), notice: "classroom has been updated"
    else
      redirect_to classrooms_path
    end
  end

  private
  def classroom_params
    params.require(:classroom).permit(:name)
  end
end
