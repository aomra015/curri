class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  before_action :authorize

  private
  def get_classroom
    @classroom = @current_user.classrooms.find(params[:classroom_id] || params[:id])
  end

  def get_track
    @track = @classroom.tracks.find(params[:track_id] || params[:id])
  end

  def get_checkpoint
    @checkpoint = @track.checkpoints.find(params[:checkpoint_id] || params[:id])
  end

  def current_user
    @current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  end
  def authorize
    redirect_to login_url if current_user.nil?
  end

  def authorize_teacher
    redirect_to classrooms_url unless current_user.teacher?
  end

  def sign_in(user, remember_me)
    if remember_me
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
    end
  end
end
