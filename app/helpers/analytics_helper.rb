module AnalyticsHelper

  SCORE_WORD = ['danger', 'warning', 'success', 'empty']

  def ratings_count(ratings, score)
    count = 0
    if ratings.any?
      ratings.each do |rating|
        count += 1 if rating.score == score
      end
    end
    count
  end

  def percent_score(ratings, score, checkpoint)
    if ratings.any?
      ratings_count(ratings, score) * 100.0 / student_count(checkpoint)
    else
      0
    end
  end

  def no_ratings(ratings, checkpoint)
    number_students = student_count(checkpoint)
    count = number_students - ratings.length
    percent = count * 100.0 / number_students
    { count: count, percent: percent }
  end

  def student_count(checkpoint)
    checkpoint.track.classroom.students.size
  end

  def render_bar(count, score, percent)
    bar = content_tag :div, count, class: "progress-bar progress-bar-#{SCORE_WORD[score]}", style: "width: #{percent}%"
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
