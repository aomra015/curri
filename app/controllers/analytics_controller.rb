class AnalyticsController < ApplicationController

  before_action :authorize_teacher
  before_action :get_classroom

  def show
    @track = @classroom.tracks.find(params[:track_id])
    @phase = Phase.new(@track, params[:phase_state] || "Realtime")
    flash.now[:track] = { event_name: "View analytics page", properties: {classroom_id: @classroom.id, track_id: @track.id, phase_state: @phase.state } }
  end

end
