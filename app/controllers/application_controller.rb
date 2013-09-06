class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private
  def get_classroom
    @classroom = @current_user.classrooms.find(params[:id])
  end

  def get_nested_classroom
    @classroom = @current_user.classrooms.find(params[:classroom_id])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def authorize
    redirect_to login_url, alert: 'Please log in or sign up.' if current_user.nil?
  end
end
