class InvitationsController < ApplicationController

  before_action :authorize, only: [:new, :create]
  before_action :authorize_teacher, only: [:new, :create]
  before_action :check_if_logged_in, only: [:claim]
  before_action :get_nested_classroom, only: [:new, :create]

  def new
    @invitation = Invitation.new
    @invitations = @classroom.invitations
  end

  def create
    email_array = params[:invitation_emails].split(/,|\n/)
    email_array.each { |email| email.strip! }

    email_array.each do |email|
      invitation = Invitation.new(email: email)
      invitation.classroom = @classroom
      invitation.save
      InvitationMailer.invite(invitation).deliver
    end

    if email_array
      redirect_to classroom_tracks_path(@classroom), notice: 'Invitations Sent'
    else
      render :new
    end

  end

  def claim
    @user = User.new
    @token = params[:token]
  end

  def create_student
    invitation = Invitation.find_by(token: params[:user][:token])

    if invitation && invitation.student.nil?
      @user = User.new(user_params)
      @user.classrole = Student.create
      if @user.save
        session[:user_id] = @user.id
        invitation.student = @user.classrole
        invitation.save
        redirect_to classrooms_path
      else
        render :claim
      end
    else
      flash.now.alert = "The invitation is no longer valid or the URL is incorrect"
      render :claim
    end

  end

  def login
    @token = params[:token]
  end

  def add_student
    invitation = Invitation.find_by(token: params[:user][:token])
    @user = User.find_by_email(params[:user][:email])

    if @user && @user.classrole_type != 'Student'
      flash.now.alert = "You need a student account to accept the invitation."
      render :login
    elsif invitation && invitation.student.nil?
      if @user && @user.authenticate(params[:user][:password])
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
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def check_if_logged_in
    redirect_to login_invitation_path(params[:token]) if current_user && current_user.classrole_type == 'Student'
  end
end
