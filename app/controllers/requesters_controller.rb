class RequestersController < ApplicationController

  before_action :get_classroom

  def index
    @requesters = @classroom.requesters
  end

  def reset_status
    requester = @current_user.classrole.invitations.find_by(classroom_id: @classroom.id)
    requester.toggle!(:help)

    Pusher.trigger("classroom#{@classroom.id}-requesters", 'request', { requesterPartial: render_to_string(partial: 'request', locals: { classroom: @classroom, requester: requester }), helpStatus: requester.help, requesterId: requester.id })

    redirect_to request.env['HTTP_REFERER'] ? :back : classrooms_path, notice: "Help status toggled."
  end

  def complete
    requester = @classroom.invitations.find(params[:id])

    requester.toggle!(:help)
    redirect_to request.env['HTTP_REFERER'] ? :back : classrooms_path, notice: "Help status toggled."
  end

end