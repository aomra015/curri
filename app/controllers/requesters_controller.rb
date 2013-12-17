class RequestersController < ApplicationController

  before_action :get_classroom

  def index
    @requesters = @classroom.get_requesters
  end

  def reset_status
    if @current_user.teacher?
      requester = @classroom.invitations.find(params[:invitation_id])
    else
      requester = @current_user.classrole.invitations.find_by(classroom_id: @classroom.id)
    end

    requester.toggle(:help).save
    PrivatePub.publish_to "/classrooms/#{@classroom.id}/requesters", requester: requester.id, requesters_count: @classroom.requesters_count

    redirect_to request.env['HTTP_REFERER'] ? :back : classrooms_path, notice: "Help status toggled."
  end
end