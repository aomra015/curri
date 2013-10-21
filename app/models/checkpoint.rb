class Checkpoint < ActiveRecord::Base
  belongs_to :track
  has_many :ratings

  validates  :expectation, :success_criteria, presence: true

  def ratings_count(start_time, end_time, score="all")
    if self.ratings.any?
      scoped_ratings = get_scoped_ratings(start_time, end_time)
      if score == "all"
        scoped_ratings.length
      else
        get_score_count(score, scoped_ratings)
      end
    else
      0
    end
  end

  def hasnt_voted(start_time, end_time)
    hasnt_voted_list = []
    scoped_ratings = get_scoped_ratings(start_time, end_time) if self.ratings.any?

    if self.ratings.empty? || scoped_ratings.empty?
      hasnt_voted_list << "all"

    elsif  self.track.classroom.students.count != scoped_ratings.length
      student_list = self.track.classroom.students.pluck(:id)
      scoped_ratings.each do |rating|
        student_list.delete(rating.student.id)
      end
      student_list.each do |student_id|
        hasnt_voted_list << Student.find(student_id).email.to_s
      end
    end

    hasnt_voted_list
  end

  def get_scoped_ratings(start_time, end_time)
    self.ratings.where({ created_at: start_time..end_time }).group(:student_id)
  end

  def get_score_count(score, ratings)
    count = 0
    ratings.each do |rating|
      count += 1 if rating.score == score
    end
    count
  end

  def get_score(score, start_time, end_time)
    if self.ratings.any?
      ratings_count(start_time, end_time, score) * 100.0 / ratings_count(start_time, end_time)
    else
      0
    end
  end

  def latest_student_score(student)
    ratings.where(student_id: student.id).last.try(:score).to_s
  end

end
