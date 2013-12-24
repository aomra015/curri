class Checkpoint < ActiveRecord::Base
  belongs_to :track
  has_many :ratings

  validates  :expectation, :success_criteria, presence: true

  default_scope { order(id: :asc) }

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

  def hasnt_voted(phase)
    hasnt_voted_list = []
    scoped_ratings = phase.ratings(self) if self.ratings.any?

    if self.ratings.empty? || scoped_ratings.empty?
      hasnt_voted_list << "all"

    elsif  self.track.classroom.students.count != scoped_ratings.length
      student_list = self.track.classroom.students.pluck(:id)
      scoped_ratings.each do |rating|
        student_list.delete(rating.student.id)
      end
      student_list.each do |student_id|
        hasnt_voted_list << Student.find(student_id).email
      end
    end

    hasnt_voted_list
  end

  def latest_student_score(student)
    ratings.where(student_id: student.id).last.try(:score).to_s
  end

end
