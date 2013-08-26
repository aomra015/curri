class InvitationsController < ApplicationController

  before_action :check_user_login
  before_action :get_nested_classroom

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

end
