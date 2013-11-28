class RequestersController < ApplicationController
  before_action :authorize
  before_action :get_nested_classroom

  def index
    @requesters = @classroom.get_requesters
  end

  def reset_status
    if @current_user.teacher?
      requester = @classroom.invitations.find(params[:invitation_id])
    else
      requester = @current_user.classrole.invitations.find_by(classroom_id: params[:classroom_id])
    end
    requester.toggle(:help).save
    redirect_to request.env['HTTP_REFERER'] ? :back : classrooms_path, notice: "Help status toggled."
  end
end