class RatingsController < ApplicationController

  before_action :authorize_student
  before_action :get_classroom
  before_action :get_track
  before_action :get_checkpoint

  def create
    score = params[:value].to_i

    if !Rating::OPTIONS[score]
      head 422
    else
      rating = @checkpoint.ratings.create(score: score, student: current_user.classrole)
      push_to_channel

      respond_to do |format|
        format.json {
          render json: { classroom_id: @classroom.id, track_id: @track.id, checkpoint_id: @checkpoint.id, current_score: rating.score, partial: render_to_string(partial: "face#{rating.score}.html", formats: :html) }
        }
        format.html {
          redirect_to classroom_track_url(@classroom, @track), notice: 'Checkpoint rating recorded.'
        }
      end

    end
  end

  private
  def authorize_student
    redirect_to classroom_track_path(params[:classroom_id], params[:track_id]), alert: "Only students can rate" if current_user.classrole_type != 'Student'
  end

  def push_to_channel
    ratings = @checkpoint.ratings.distinct_by_student.to_json(only: :score)
    Pusher.trigger("track#{@track.id}-ratings", 'rating', { checkpoint: @checkpoint.id, ratings: ratings, totalCount: @classroom.students.size })
  end

end
