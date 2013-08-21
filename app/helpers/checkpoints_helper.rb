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

  def ratings_count_box(checkpoint)
    ratings_count = checkpoint.ratings_count(@start_time, @end_time)
    big_number = content_tag :div, ratings_count, class: 'count-number'
    byline = content_tag :p, 'response'.pluralize(ratings_count)
    big_number + byline
  end

  def progress_bars(checkpoint)
    label_names = ["danger", "warning", "success"]
    bars = []

    label_names.each_with_index do |label, score|
      bar = content_tag :div, get_rating_label(checkpoint, score), class: "progress-bar progress-bar-#{label}", style: "width: #{checkpoint.get_score(score, @start_time, @end_time)}%"
      bars << bar
    end

    bars.sum
  end

end
