class AnalyticsController < ApplicationController

  before_action :check_user_login
  before_action :get_nested_classroom

  def index
    @track = @classroom.tracks.find(params[:track_id])

    now = Time.zone.now
    @start_at = 0
    @end_at = 0

    @start_time = Rating.first.try(:created_at) || now
    @end_time = now
  end

  def scope
    @tracks = @classroom.tracks
    now = Time.zone.now
    @start_at = params[:start_at].to_i
    @end_at = params[:end_at].to_i

    @start_time = now - @start_at*60
    @end_time = now - @end_at*60

    render :index
  end
end
