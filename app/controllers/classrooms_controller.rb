class ClassroomsController < ApplicationController

  before_action :authorize_teacher, except: [:index, :show, :destroy]
  before_action :get_classroom, only: [:edit, :update, :destroy]

  def index
    @classrooms = @current_user.classrooms
  end

  def create
    @classroom = Classroom.new(classroom_params)
    @classroom.teachers << @current_user.classrole

    respond_to do |format|
      if @classroom.save
        format.json { render json: { partial: render_to_string(partial: 'classroom.html', locals: { classroom: @classroom }), id: @classroom.id }, status: :created, location: @classroom }
      else
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    classroom = Classroom.find_by(teacher_token: params[:teacher_token])
    respond_to do |format|
      if classroom && @current_user.classrooms.exclude?(classroom)
        @current_user.classrooms << classroom
        format.json { render json: { partial: render_to_string(partial: 'classroom.html', locals: { classroom: classroom }), id: classroom.id }, status: :created, location: classroom }
      else
        if @current_user.classrooms.include?(classroom)
          message = 'You are already in this classroom'
        else
          message = 'Invalid Token'
        end
        format.json { render json: message, status: :unprocessable_entity }
      end
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
