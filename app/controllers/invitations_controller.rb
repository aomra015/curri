class InvitationsController < ApplicationController

  before_action :authorize, only: [:new, :create, :destroy]
  before_action :authorize_teacher, only: [:new, :create, :destroy]
  before_action :check_if_logged_in, only: [:claim]
  before_action :get_nested_classroom, only: [:new, :create, :destroy]

  def new
    @invitation = Invitation.new
    @invitations = @classroom.invitations
  end

  def create
    emails = params[:invitation_emails].split(/,|\n/)
    invitations = []

    emails.each do |email|
      invitation = Invitation.new(email: email.strip)
      invitation.classroom = @classroom

      if invitation.invalid?
        flash[:alert] = "Invalid email format"
        @invitations = @classroom.invitations
        render :new and return
      else
        invitations << invitation
      end
    end

    invitations.each do |inv|
      inv.save
      InvitationMailer.invite(inv).deliver
    end
    redirect_to classroom_tracks_path(@classroom), notice: 'Invitations Sent'

  end

  def claim
    @user = User.new
    @token = params[:token]
  end

  def create_student
    @token = params[:user][:token]
    invitation = Invitation.find_by(token: @token)

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

  def destroy
    invitation = @classroom.invitations.find(params[:id])
    invitation.destroy
    redirect_to new_classroom_invitation_url(@classroom), notice: 'Invitation Removed'
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def check_if_logged_in
    redirect_to login_invitation_path(params[:token]) if current_user && current_user.classrole_type == 'Student'
  end
end
