class InvitationsController < ApplicationController

  before_action :authorize_teacher
  before_action :get_classroom

  def new
    @invitation = Invitation.new
    @invitations = @classroom.invitations
  end

  def create
    invitation_creator = InvitationCreator.new(params[:invitation_emails], @classroom)

    if invitation_creator.save
      redirect_to new_classroom_invitation_path(@classroom), notice: 'Invitations Sent'
    else
      flash[:alert] = "Invalid email format"
      @invitations = @classroom.invitations
      render :new
    end
  end

  def destroy
    invitation = @classroom.invitations.find(params[:id])
    invitation.destroy

    respond_to do |format|
      format.json {
        render json: { id: params[:id] }
      }
      format.html {
        redirect_to new_classroom_invitation_url(@classroom), notice: 'Invitation Removed'
      }
    end
  end
end
