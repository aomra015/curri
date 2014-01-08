class RequestersController < ApplicationController

  before_action :get_classroom
  before_action :get_requester, except: [:index]
  respond_to :html, :json

  def index
    @requesters = @classroom.requesters
  end

  def show
    respond_with help: @requester.help
  end

  def update
    @requester.toggle!(:help)

    Pusher.trigger("classroom#{@classroom.id}-requesters", 'request', { requesterPartial: render_to_string(partial: 'request', locals: { classroom: @classroom, requester: @requester }), helpStatus: @requester.help, requesterId: @requester.id })

    redirect_to request.env['HTTP_REFERER'] ? :back : classrooms_path, notice: "Queue status changed successfully"
  end

  def remove
    @requester.help = false
    @requester.save
    redirect_to request.env['HTTP_REFERER'] ? :back : classrooms_path, notice: "Student removed from queue."
  end

  private
  def get_requester
    @requester = @classroom.invitations.find(params[:id])
  end

end