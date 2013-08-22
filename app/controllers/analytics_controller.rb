class AnalyticsController < ApplicationController

  def index
    @tracks = Track.all
    now = Time.zone.now
    @start_at = 0
    @end_at = 0

    @start_time = Rating.first.try(:created_at) || now
    @end_time = now
  end

  def scope
    now = Time.zone.now
    @start_at = params[:start_at].to_i
    @end_at = params[:end_at].to_i

    @start_time = now - @start_at*60
    @end_time = now - @end_at*60
    @tracks = Track.all
    render :index
  end
end
