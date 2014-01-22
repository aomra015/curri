class StudentsController < ApplicationController

  skip_before_action :authorize
  before_action :check_if_logged_in, only: [:new]
  before_action :get_invitation, only: [:create, :enroll]

  def new
    @user = User.new
    @token = params[:token]
    render layout: "login_layout"
  end

  def create
    @user = User.new(user_params)
    @user.classrole = Student.create
    if @user.save
      flash[:track] = { event_name: "Student Sign Up" }
      claim_invitation
    else
      render :new, layout: "login_layout"
    end
  end

  def login
    @token = params[:token]
    render layout: "login_layout"
  end

  def enroll
    @user = User.find_by_email(params[:user][:email])

    if !@user.try(:student?)
      flash.now.alert = "You need a student account to accept the invitation."
      render :login, layout: "login_layout"
    else
      if @user.try(:authenticate, params[:user][:password])
        flash[:track] = { event_name: "User joins classroom" }
        claim_invitation
      else
        flash.now.alert = "Email or password are not correct"
        render :login, layout: "login_layout"
      end
    end

  end

  private
  def get_invitation
    @token = params[:user][:token]
    @invitation = Invitation.find_by(token: @token)
    if @invitation.nil? || @invitation.student
      flash.now.alert = "The invitation is no longer valid or the URL is incorrect"
      action = params[:action] == 'create' ? :new : :login
      render action, layout: "login_layout"
    end
  end

  def claim_invitation
    if @user.classrooms.include?(@invitation.classroom)
      @invitation.destroy
    else
      @invitation.student = @user.classrole
      @invitation.save
    end

    session[:user_id] = @user.id
    redirect_to classrooms_path
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

  def check_if_logged_in
    redirect_to students_login_path(params[:token]) if current_user.try(:student?)
  end
end