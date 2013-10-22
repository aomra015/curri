module AnalyticsHelper

  def get_rating_label(checkpoint, score)
    label = checkpoint.ratings_count(@start_time, @end_time, score)
    label
  end

  def ratings_count_box(checkpoint)
    ratings_count = checkpoint.ratings_count(@start_time, @end_time)
    big_number = content_tag :div, ratings_count, class: 'count-number'
    byline = content_tag :p, 'response'.pluralize(ratings_count)
    big_number + byline
  end

  def hasnt_voted_box(checkpoint)
    hasnt_voted_list = checkpoint.hasnt_voted(@start_time, @end_time)
    output = content_tag :p, "Hasn't voted:"
    output = content_tag :p, "" if hasnt_voted_list.empty?
    hasnt_voted_list.each do |email|
      output += content_tag :li, email
    end
    output
  end

end
