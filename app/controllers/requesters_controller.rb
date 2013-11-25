class RequestersController < ApplicationController
  before_action :authorize
  before_action :authorize_teacher
  before_action :get_nested_classroom

  def index
    @requesters = @classroom.get_requesters
  end

  def reset_status
    requester = @classroom.invitations.find(params[:id])
    requester.toggle(:help).save
    redirect_to classroom_requesters_path(@classroom), notice: "Help status toggled."
  end
end