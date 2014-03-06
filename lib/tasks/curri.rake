namespace :curri do
  desc "Add position value to older checkpoints"
  task checkpoint_positions: :environment do
    Checkpoint.all.find_each do |checkpoint|
      checkpoint.position = checkpoint.id
      checkpoint.save
    end
  end

  desc "Add position value to older tracks"
  task track_positions: :environment do
    Track.all.find_each do |track|
      track.position = track.id
      track.save
    end
  end

  desc "Add gravatars to existing Users"
  task add_gravatars: :environment do
    User.all.find_each do |user|
      user.save
    end
  end

  desc "Add authtokens to existing Users"
  task user_authtokens: :environment do
    User.all.find_each do |user|
      user.generate_token(:auth_token)
      user.save
    end
  end

  desc "Add request object to existing Students"
  task student_requests: :environment do
    Student.all.find_each do |student|
      student.classrooms.find_each do |cls|
        Requester.create(classroom: cls, student: student)
      end
    end
  end

end
