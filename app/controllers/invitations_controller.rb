class InvitationsController < ApplicationController

  before_action :check_user_login
  before_action :get_nested_classroom, only: [:new, :create]

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(email: params[:invitation][:email])
    @invitation.classroom = @classroom

    if @invitation.save
      InvitationMailer.invite(@invitation).deliver
      redirect_to classroom_tracks_path(@classroom), notice: 'Invitation Sent'
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
      render :claim, error: "The invitation is no longer valid or the URL is incorrect"
    end

  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
