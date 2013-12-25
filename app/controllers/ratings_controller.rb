class RatingsController < ApplicationController

  before_action :authorize_student
  before_action :get_classroom

  def create
    score = params[:value].to_i

    if !Rating::OPTIONS[score]
      head 422
    else
      @track = @classroom.tracks.find(params[:track_id])
      @checkpoint = @track.checkpoints.find(params[:checkpoint_id])

      @rating = @checkpoint.ratings.new(score: score)
      @rating.student = current_user.classrole
      @rating.save

      PrivatePub.publish_to "/track/#{@track.id}/ratings", checkpoint: @checkpoint.id, ratings: @checkpoint.ratings.select("DISTINCT ON (student_id) * ").order("student_id, created_at DESC"), totalCount: @classroom.students.size

      respond_to do |format|
        format.json {
          render json: { checkpoint_id: @checkpoint.id, current_score: @rating.score }
        }
        format.html {
          redirect_to classroom_track_url(@classroom, @track)
        }
      end

    end
  end

  private
  def authorize_student
    redirect_to classroom_track_path(params[:classroom_id], params[:track_id]), alert: "Only students can rate" if current_user.classrole_type != 'Student'
  end

end
