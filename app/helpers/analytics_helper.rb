module AnalyticsHelper

  SCORE_WORD = ['danger', 'warning', 'success']

  def ratings_count(ratingData, score="all")
    if ratingData.any?
      if score == "all"
        ratingData.size
      else
        get_score_count(score, ratingData)
      end
    else
      0
    end
  end

  def get_score_count(score, scoped_ratings)
    count = 0
    scoped_ratings.each do |rating|
      count += 1 if rating.score == score
    end
    count
  end

  def get_score(score, ratingData)
    if ratingData.any?
      ratings_count(ratingData, score) * 100.0 / ratings_count(ratingData)
    else
      0
    end
  end

  def render_bar(ratings, score)
    bar = content_tag :div, ratings_count(ratings, score), class: "progress-bar progress-bar-#{SCORE_WORD[score]}", style: "width: #{get_score(score, ratings)}%"
  end

  def ratings_count_box(checkpoint)
    ratingData = @phase.ratings(checkpoint)
    ratings_count_num = ratings_count(ratingData)
    big_number = content_tag :div, ratings_count_num, class: 'count-number'
    byline = content_tag :p, 'response'.pluralize(ratings_count_num)
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
