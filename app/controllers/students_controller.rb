class StudentsController < ApplicationController

  skip_before_action :authorize
  before_action :check_if_logged_in, only: [:new]

  def new
    @user = User.new
    @token = params[:token]
  end

  def create
    @token = params[:user][:token]
    invitation = Invitation.find_by(token: @token)

    if invitation.try(:claimable?)
      @user = User.new(user_params)
      @user.classrole = Student.create
      if @user.save
        session[:user_id] = @user.id
        invitation.student = @user.classrole
        invitation.save
        redirect_to classrooms_path
      else
        render :new
      end
    else
      flash.now.alert = "The invitation is no longer valid or the URL is incorrect"
      render :new
    end

  end

  def login
    @token = params[:token]
  end

  def enroll
    invitation = Invitation.find_by(token: params[:user][:token])
    @user = User.find_by_email(params[:user][:email])

    if !@user.try(:student?)
      flash.now.alert = "You need a student account to accept the invitation."
      render :login
    elsif invitation.try(:claimable?)
      if @user.try(:authenticate, params[:user][:password])
        session[:user_id] = @user.id
        invitation.student = @user.classrole
        invitation.save
        redirect_to classrooms_path
      else
        flash.now.alert = "Email or password are not correct"
        render :login
      end
    else
      flash.now.alert = "The invitation is no longer valid or the URL is incorrect"
      render :login
    end

  end

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

  def check_if_logged_in
    redirect_to students_login_path(params[:token]) if current_user.try(:student?)
  end
end