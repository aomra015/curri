# setting up some sample teacher/student data
teacher_role = Teacher.create()
myteacher = User.create(email: "teacher1@fakemail.com", classrole: teacher_role, classrole_type: "Teacher" , password: "1234", password_confirmation: "1234" )

default_classroom = teacher_role.classrooms.find_by(name: "Sample Classroom")
js_track = default_classroom.tracks.find_by(name: "Beginner JavaScript")
js_checkpoints = js_track.checkpoints

num_students = 4
student_roles = []
num_students.times {|i| student_roles << Student.create()}

myinvitations = []
num_students.times {|i| myinvitations << Invitation.create(student: student_roles[i], classroom: default_classroom, token: "esteem", email: "fakestudent#{i+1}@gmail.com") }

mystudents = []
num_students.times {|i| mystudents << User.create(email: "student#{i+1}@fakemail.com",
  classrole: student_roles[i], classrole_type: "Student" , password: "1234", password_confirmation: "1234" )}

mydates = [Time.zone.parse("2012-10-1 2pm"), Time.zone.parse("2012-10-10 2pm"), Time.zone.parse("2012-10-15 2pm")]

js_track.created_at = Time.zone.parse("2012-9-8 2pm")
js_track.start_time = Time.zone.parse("2012-10-8 2pm")
js_track.end_time = Time.zone.parse("2012-10-12 2pm")
js_track.save

# 3D ratings array holds 10 ratings per student (4) per date (3)
# Rating creation checks for nil score entries and if so doesn't create rating
myscores = [[[]]]
myscores[0] = [ [  2,  2,  1,  1,  0,  0,nil,nil,nil,nil],
                 [  1,  1,  1,nil,nil,nil,nil,  0,  1,  1],
                 [  2,  2,  2,  1,  1,  1,  1,  1,  1,  1],
                 [nil,nil,nil,nil,nil,  0,  0,  0,  0,  0]]
myscores[1] = [ [  2,  2,  2,  2,  2,  1,  0,  0,nil,nil],
                 [  1,  1,  2,  1,  1,  2,  1,  0,  1,  1],
                 [  2,  2,  2,  1,  1,  2,  2,  2,  2,  1],
                 [nil,nil,  1,  0,  0,  1,  1,  0,  1,  1]]
myscores[2] = [ [  2,  2,nil,  2,  2,  2,  2,  2,  2,  2],
                 [  1,  2,nil,  1,  1,nil,  1,  1,  2,  2],
                 [  1,  2,nil,  2,  2,nil,  2,  2,  2,  1],
                 [  2,nil,nil,  1,  0,  1,  1,  0,  1,  1]]
num_ratings = myscores[0][0].length

num_ratings.times {|i|
  num_students.times {|j|
    mydates.length.times {|k|
  student_roles[j].ratings.create(checkpoint: js_checkpoints[i], score: myscores[k][j][i], created_at: mydates[k]) if myscores[k][j][i]}}}





