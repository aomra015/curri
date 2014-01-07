class RequestersController < ApplicationController

  before_action :get_classroom

  def index
    @requesters = @classroom.requesters
  end

  def reset_status
    if @current_user.teacher?
      requester = @classroom.invitations.find(params[:invitation_id])
    else
      requester = @current_user.classrole.invitations.find_by(classroom_id: @classroom.id)
    end

    requester.toggle(:help).save
    # Pusher["classroom#{@classroom.id}-requesters"].trigger('request', { requester: requester.id, requesters_count: @classroom.requesters.size })

    redirect_to request.env['HTTP_REFERER'] ? :back : classrooms_path, notice: "Help status toggled."
  end

end