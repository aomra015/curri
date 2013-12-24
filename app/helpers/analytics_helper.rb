module AnalyticsHelper

  SCORE_WORD = ['Danger', 'Warning', 'Success']

  def get_rating_label(checkpoint, score)
    ratingData = @phase.ratings(checkpoint)
    label = checkpoint.ratings_count(ratingData, score)
    label
  end

  def ratings_count_box(checkpoint)
    ratingData = @phase.ratings(checkpoint)
    ratings_count = checkpoint.ratings_count(ratingData)
    big_number = content_tag :div, ratings_count, class: 'count-number'
    byline = content_tag :p, 'response'.pluralize(ratings_count)
    big_number + byline
  end

  def hasnt_voted_box(checkpoint)
    hasnt_voted_list = checkpoint.hasnt_voted(@phase)
    output = content_tag :p, "Hasn't voted:"
    output = content_tag :p, "" if hasnt_voted_list.empty?
    hasnt_voted_list.each do |email|
      output += content_tag :li, email
    end
    output
  end

  # def render_bar(ratings, score)
  #   bar = content_tag :div, class: "progress-bar progress-bar-#{SCORE_WORD[score]}", style: "width= #{}" do

  #   end
  # end

end
