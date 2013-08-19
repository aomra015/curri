module CheckpointsHelper

  def checkpoint_select_tag_name(checkpoint)
    "checkpoints[checkpoint_#{checkpoint.id}][:score]]"
  end

  def checkpoint_hidden_tag_name(checkpoint)
    "checkpoints[checkpoint_#{checkpoint.id}][:id]]"
  end
end
