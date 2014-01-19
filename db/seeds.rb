# setting up some sample teacher/student data
def make_accounts(teacher_email, student_emails, passwd)
  teacher_role = Teacher.create()
  myteacher = User.create(email: teacher_email, classrole: teacher_role, classrole_type: "Teacher" , password: passwd, password_confirmation: passwd )

  default_classroom = teacher_role.classrooms.find_by(name: "Sample Classroom")
  js_track = default_classroom.tracks.find_by(name: "Beginner JavaScript")
  js_checkpoints = js_track.checkpoints

  num_students = student_emails.length
  student_roles = []
  num_students.times {|i| student_roles << Student.create()}

  myinvitations = []
  num_students.times {|i| myinvitations << Invitation.create(student: student_roles[i],  classroom: default_classroom, token: "esteem", email: student_emails[i]) }

  mystudents = []
  num_students.times {|i| mystudents << User.create(email: student_emails[i],
    first_name: "Student#{i+1}", last_name: "S#{i+1}",
    classrole: student_roles[i], classrole_type: "Student" , password: passwd, password_confirmation: passwd )}

  mydates = [Time.zone.parse("2012-10-1 2pm"), Time.zone.parse("2012-10-10 2pm"), Time.zone.parse("2012-10-15 2pm")]

  js_track.created_at = Time.zone.parse("2012-9-8 2pm")
  js_track.start_time = Time.zone.parse("2012-10-8 2pm")
  js_track.end_time = Time.zone.parse("2012-10-12 2pm")
  js_track.save

  # 3D ratings array holds 10 ratings per student (up to 8) per date (3)
  # Rating creation checks for nil score entries and if so doesn't create rating
  myscores = [[[]]]
  myscores[0] = [ [  2,  2,  1,  1,  0,  0,nil,nil,nil,nil],
                   [  1,  1,  1,nil,nil,nil,nil,  0,  1,  1],
                   [  2,  2,  2,  1,  1,  1,  1,  1,  1,  1],
                   [nil,nil,nil,nil,nil,  0,  0,  0,  0,  0],
                   [  1,  1,  2,  1,  0,  2,nil,nil,1,nil],
                   [  2,  1,  0,nil,nil,nil,nil,  0,  1,  1],
                   [  1,  2,  1,  1,  1,  0,  0,  nil,  1,  1],
                   [  1,nil,1,nil,nil,  1,  0,  0,  0,  1]]
  myscores[1] = [ [  2,  2,  2,  2,  2,  1,  0,  0,nil,nil],
                   [  1,  1,  2,  1,  1,  2,  1,  0,  1,  1],
                   [  2,  2,  2,  1,  1,  2,  2,  2,  2,  1],
                   [nil,nil,  1,  0,  0,  1,  1,  0,  1,  1],
                   [  2,  1,  2,  1,  1,  2,nil,  2,  1,  2],
                   [  2,  2,  1,nil,nil,1,2,  0,  1,  1],
                   [  1,  2,  2,  1,  2,  1,  0,  1,  1,  1],
                   [  1,  1,  1,  1,nil,  1,  0,  0,  0,  1]]
  myscores[2] = [ [  2,  2,nil,  2,  2,  2,  2,  2,  2,  2],
                   [  1,  2,nil,  1,  1,nil,  1,  1,  2,  2],
                   [  1,  2,nil,  2,  2,nil,  2,  2,  2,  1],
                   [  2,nil,nil,  1,  0,  1,  1,  0,  1,  1],
                   [  2,  2,  2,  1,  1,  2,  1,  2,  1,  2],
                   [  2,  2,  1,  1,  1,  1,  2,  1,  2,  1],
                   [  1,  2,  2,  2,  2,  1,  1,  2,  2,  1],
                   [  1,  2,  1,  1,nil,  1,  1,  1,  2,  2]]
  num_ratings = myscores[0][0].length

  num_ratings.times {|i|
    num_students.times {|j|
      mydates.length.times {|k|
    student_roles[j].ratings.create(checkpoint: js_checkpoints[i], score: myscores[k][j][i], created_at: mydates[k]) if myscores[k][j][i]}}}
end
make_accounts("teacher1@fakemail.com", ["student1@fakemail.com", "student2@fakemail.com", "student3@fakemail.com", "student4@fakemail.com"], "1234")
make_accounts("teacher@mail.com", ["student1@mail.com", "student2@mail.com", "student3@mail.com", "student4@mail.com",
  "student5@mail.com", "student6@mail.com", "student7@mail.com", "student8@mail.com"], "abcd")
make_accounts("teacher1@mail.com", ["student_1@mail.com", "student_2@mail.com", "student_3@mail.com", "student_4@mail.com"], "defg")


