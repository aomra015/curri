class SessionsController < ApplicationController

  skip_before_action :authorize

  def new
    render layout: "login_layout"
  end

  def create
    user = User.find_by_email(params[:email])
    if user.try(:authenticate, params[:password])
      sign_in(user, params[:remember_me])
      flash[:track] = { event_name: "User Sign In" }
      redirect_to classrooms_path
    else
      flash.now.alert = "Email or password are not correct"
      render :new, layout: "login_layout"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to login_path
  end
end
