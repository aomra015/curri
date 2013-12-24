module CheckpointsHelper

  def checkpoint_class_name(checkpoint)
    "checkpoint_" + checkpoint.latest_student_score(current_user.classrole)
  end

end
