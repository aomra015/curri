module CheckpointsHelper

  def checkpoint_select_tag_name(checkpoint)
    "checkpoints[checkpoint_#{checkpoint.id}][:score]]"
  end

  def checkpoint_hidden_tag_name(checkpoint)
    "checkpoints[checkpoint_#{checkpoint.id}][:id]]"
  end

  def checkpoint_class_name(checkpoint)
    "checkpoint_" + checkpoint.latest_student_score(current_user.classrole)
  end

end
