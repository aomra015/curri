class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to classrooms_path, notice: "You are connected as #{user.username}"
    else
      flash.now.alert = "Email or password are not correct"
      render :new
    end
  end
end
