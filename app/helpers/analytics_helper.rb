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
    { count: count, percent: percent }
  end

  def no_ratings(ratings, total_count)
    count = total_count - ratings.length
    percent = count * 100.0 / total_count
    { count: count, percent: percent }
  end

  def student_count(checkpoint)
    checkpoint.track.classroom.students.size
  end

  def render_bar(counts, score)
    bar = content_tag :div, counts[:count], class: "progress-bar progress-bar-#{SCORE_WORD[score]}", style: "width: #{counts[:percent]}%"
  end

  def ratings_count_box(checkpoint)
    count_num = @phase.ratings(checkpoint).length
    big_number = content_tag :div, count_num, class: 'count-number'
    byline = content_tag :p, 'response'.pluralize(count_num)
    big_number + byline
  end

  def hasnt_voted(ratings)
    return ["all"] if ratings.empty?

    classroom = ratings.first.checkpoint.track.classroom
    if classroom.students.size != ratings.length
      student_list = classroom.students.pluck(:id)
      ratings.each do |rating|
        student_list.delete(rating.student.id)
      end
      student_list.map { |id| Student.find(id).email }
    else
      []
    end
  end

  def hasnt_voted_box(checkpoint)
    hasnt_voted_list = hasnt_voted(@phase.ratings(checkpoint))
    output = content_tag :p, "Hasn't voted:"
    output = content_tag :p, "" if hasnt_voted_list.empty?
    hasnt_voted_list.each do |email|
      output += content_tag :li, email
    end
    output
  end

end
