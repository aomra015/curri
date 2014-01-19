class ClassroomsController < ApplicationController

  before_action :authorize_teacher, except: [:index, :show, :destroy]
  before_action :get_classroom, only: [:edit, :update, :destroy]

  def index
    @classrooms = @current_user.classrooms
  end

  def new
    @classroom = Classroom.new
  end

  def create
    @classroom = Classroom.new(classroom_params)
    @classroom.teachers << @current_user.classrole
    if @classroom.save
      redirect_to classrooms_path, notice: "Your new classroom '#{@classroom.name}' has been created."
    else
      render :new
    end
  end

  def join
    classroom = Classroom.find_by(teacher_token: params[:teacher_token])

    if classroom
      @current_user.classrooms << classroom
      redirect_to classrooms_path, notice: "You have joined '#{classroom.name}' as a teacher."
    else
      @classroom = Classroom.new
      flash.now.alert = 'Invalid Token'
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
    @current_user.classrooms.delete(@classroom)
    if @classroom.teachers.empty? && @classroom.students.empty?
      @classroom.destroy
    end
    redirect_to classrooms_path, notice: "You have left the classroom."
  end

  private
  def classroom_params
    params.require(:classroom).permit(:name, :description)
  end
end
