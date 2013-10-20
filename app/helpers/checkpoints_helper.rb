module CheckpointsHelper

  def checkpoint_select_tag_name(checkpoint)
    "checkpoints[checkpoint_#{checkpoint.id}][:score]]"
  end

  def checkpoint_hidden_tag_name(checkpoint)
    "checkpoints[checkpoint_#{checkpoint.id}][:id]]"
  end

  def checkpoint_class_name(checkpoint)
    "checkpoint_" + checkpoint.ratings.where(student_id: current_user.classrole.id).last.try(:score).to_s
  end

end
