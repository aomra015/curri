class RequestersController < ApplicationController

  before_filter :authorize_teacher, only: [:index, :remove]
  before_action :get_classroom
  before_action :get_requester, except: [:index]
  respond_to :html, :json

  def index
    @requesters = @classroom.requesters

    respond_to do |format|
      format.json {
        render json: { requesters: @requesters.to_json(only: [:student_id, :updated_at, :help]) }
      }
      format.html {}
    end
  end

  def show
    respond_with help: @requester.help
  end

  def update
    @requester.toggle!(:help)

    Pusher.trigger("classroom#{@classroom.id}-requesters", 'request', { requesterPartial: render_to_string(partial: 'request', locals: { classroom: @classroom, requester: @requester }), helpStatus: @requester.help, requesterId: @requester.id })

    if @requester.help
      message = "Your teacher was notified that you need help."
      flash[:track] = { event_name: "Student Asked for Help" }
    else
      message = "You were removed from the help queue."
    end

    respond_to do |format|
      format.json {
        render json: { help: @requester.help, message: message }
      }
      format.html {
        flash[:notice] = message
        redirect_to request.env['HTTP_REFERER'] ? :back : classrooms_path
      }
    end
  end

  def remove
    @requester.help = false
    @requester.save

    respond_to do |format|
      format.json {
        render json: { id: params[:id] }
      }
      format.html {
        flash[:notice] = "Student removed from queue."
        flash[:track] = { event_name: "Teacher Answered Student" }
        redirect_to request.env['HTTP_REFERER'] ? :back : classrooms_path
      }
    end
  end

  private
  def get_requester
    @requester = @classroom.invitations.find(params[:id])
  end

end