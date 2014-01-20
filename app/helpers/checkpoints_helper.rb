module CheckpointsHelper

  def last_rating(checkpoint)
    score = checkpoint.latest_student_score(current_user.classrole)
    score || 'caret'
  end

end
