class SessionsController < ApplicationController

  skip_before_action :authorize

  def new
    render layout: "login_layout"
  end

  def create
    user = User.find_by_email(params[:email])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to classrooms_path, notice: "You are signed in as #{user.email}"
    else
      flash.now.alert = "Email or password are not correct"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
