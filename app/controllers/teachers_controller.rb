class TeachersController < ApplicationController

  skip_before_action :authorize

  def new
    @user = User.new
    render layout: "login_layout"
  end

  def create
    @user = User.new(user_params)
    @user.classrole = Teacher.create

    if @user.save
      session[:user_id] = @user.id
      redirect_to classrooms_path
    else
      render :new, layout: "login_layout"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
