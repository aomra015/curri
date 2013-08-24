class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def get_classroom
    @classroom = @current_user.classrooms.find(params[:id])
  end

  def get_nested_classroom
    @classroom = @current_user.classrooms.find(params[:classroom_id])
  end

  def check_user_login
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      redirect_to login_path, alert: 'Please log in or sign up.'
    end
  end
end
