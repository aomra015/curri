module AnalyticsHelper

  SCORE_WORD = ['danger', 'warning', 'success', 'empty']

  def ratings_count(ratings, total_count, score)
    count = 0
    if ratings.any?
      ratings.each do |rating|
        count += 1 if rating.score == score
      end
    end
    percent = count * 100.0 / total_count
    { count: count, percent: percent, score: score }
  end

  def no_ratings(ratings, total_count)
    count = total_count - ratings.length
    percent = count * 100.0 / total_count
    { count: count, percent: percent, score: 3 }
  end

  def render_bar(counts)
    content_tag :div, counts[:count], class: "progress-bar progress-bar-#{SCORE_WORD[counts[:score]]}", style: "width: #{counts[:percent]}%"
  end

  def ratings_count_box(checkpoint)
    count_num = @phase.ratings(checkpoint).length
    big_number = content_tag :div, count_num, class: 'count-number'
    byline = content_tag :p, 'response'.pluralize(count_num)
    big_number + byline
  end

  def hasnt_voted_box(checkpoint)
    hasnt_voted_list = checkpoint.hasnt_voted(@phase, @classroom)
    output = content_tag :p, "Hasn't voted:"
    output = content_tag :p, "" if hasnt_voted_list.empty?
    hasnt_voted_list.each do |email|
      output += content_tag :li, email
    end
    output
  end

end
