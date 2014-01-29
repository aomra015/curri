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
    percent = counts[:count] == 0 ? '' : "#{counts[:percent].round}%"
    content_tag :div, percent, class: "progress-bar progress-bar-#{SCORE_WORD[counts[:score]]}", style: "width: #{percent}"
  end

  def ratings_count_box(checkpoint)
    count_num = @phase.ratings(checkpoint).length
    big_number = content_tag :div, count_num, class: 'count-number'
    byline = content_tag :p, 'response'.pluralize(count_num)
    big_number + byline
  end

  def hasnt_voted_box(hasnt_voted)
    content_tag :div, class: 'hasnt-voted' do
      concat(content_tag :h6, "Students that haven't voted:")
      concat(content_tag(:span, hasnt_voted.join(', ') + '.', class: 'student-not-voted'))
      concat(content_tag :div, "Note: Student list only shows when less than 25% of class hasn't voted", class: 'hasnt-voted-note')
    end
  end

end
