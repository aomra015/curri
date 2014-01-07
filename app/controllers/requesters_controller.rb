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

  def toggle
    @requester.toggle!(:help)

    Pusher.trigger("classroom#{@classroom.id}-requesters", 'request', { requesterPartial: render_to_string(partial: 'request', locals: { classroom: @classroom, requester: @requester }), helpStatus: @requester.help, requesterId: @requester.id })

    redirect_to request.env['HTTP_REFERER'] ? :back : classrooms_path, notice: "Help status toggled."
  end

  def complete
    @requester.toggle!(:help)
    redirect_to request.env['HTTP_REFERER'] ? :back : classrooms_path, notice: "Help status toggled."
  end

  private
  def get_requester
    @requester = @classroom.invitations.find(params[:id])
  end

end