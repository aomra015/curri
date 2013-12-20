class AnalyticsController < ApplicationController

  before_action :authorize_teacher
  before_action :get_classroom

  def show
    @track = @classroom.tracks.find(params[:track_id])
    @phase = Phase.new(@track, params[:phase_text] || "All")
  end

end
