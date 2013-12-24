module AnalyticsHelper

  SCORE_WORD = ['danger', 'warning', 'success']

  def ratings_count(ratingData, score)
    count = 0
    if ratingData.any?
      ratingData.each do |rating|
        count += 1 if rating.score == score
      end
    end
    count
  end

  def get_score(ratingData, score)
    if ratingData.any?
      ratings_count(ratingData, score) * 100.0 / ratingData.length
    else
      0
    end
  end

  def render_bar(ratings, score)
    bar = content_tag :div, ratings_count(ratings, score), class: "progress-bar progress-bar-#{SCORE_WORD[score]}", style: "width: #{get_score(ratings, score)}%"
  end

  def ratings_count_box(checkpoint)
    count_num = @phase.ratings(checkpoint).length
    big_number = content_tag :div, count_num, class: 'count-number'
    byline = content_tag :p, 'response'.pluralize(count_num)
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

end
