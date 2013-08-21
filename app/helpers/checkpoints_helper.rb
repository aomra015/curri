module CheckpointsHelper

  def checkpoint_select_tag_name(checkpoint)
    "checkpoints[checkpoint_#{checkpoint.id}][:score]]"
  end

  def checkpoint_hidden_tag_name(checkpoint)
    "checkpoints[checkpoint_#{checkpoint.id}][:id]]"
  end

  def checkpoint_class_name(checkpoint)
    "checkpoint_" + session["checkpoint_#{checkpoint.id}"].to_s
  end

  def get_rating_label(checkpoint, score)
    label = checkpoint.ratings_count(@start_time, @end_time, score)
    label = "" if label == 0
    label
  end

end
