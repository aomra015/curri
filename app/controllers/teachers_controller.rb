class TeachersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.classrole = Teacher.create
    @user.add_default_classroom

    if @user.save
      session[:user_id] = @user.id
      redirect_to classrooms_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
