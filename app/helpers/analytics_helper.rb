module AnalyticsHelper

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

end
