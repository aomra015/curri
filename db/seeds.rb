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
def addStatsCourse(teacher_email, student_emails)

  myteacher = User.find_by(email: teacher_email)
  teacher_role = myteacher.classrole
  classroom_already_there = teacher_role.classrooms.find_by(name: "Introduction to Statistics")
  unless classroom_already_there
    add_second_sample_classroom(teacher_role)
    default_classroom = teacher_role.classrooms.find_by(name: "Introduction to Statistics")
    track_1 = default_classroom.tracks.find_by(name: "Track 1: Introduction and Terminology")
    track_1_checkpoints = track_1.checkpoints
    track_2 = default_classroom.tracks.find_by(name: "Track 2: Visualizing data; Mean, Median and Mode")
    track_2_checkpoints = track_2.checkpoints

    students = User.all.where(email: student_emails)

    num_students = students.length
    student_roles = []
    num_students.times {|i| student_roles << students[i].classrole }

    myinvitations = []
    num_students.times {|i| myinvitations << Invitation.create(student: student_roles[i],  classroom: default_classroom, token: "esteem", email: student_emails[i]) }

    mydates = [Time.zone.parse("2014-1-20 6pm"), Time.zone.parse("2014-1-22 7pm"), Time.zone.parse("2014-1-23 1pm")]
    mydates2 = [Time.zone.parse("2014-1-21 6pm"), Time.zone.parse("2014-1-23 7pm"), Time.zone.parse("2014-1-24 1pm")]
    track_1.created_at = Time.zone.parse("2014-1-20 2pm")
    track_1.start_time = Time.zone.parse("2014-1-22 6pm")
    track_1.end_time = Time.zone.parse("2014-1-22 8pm")
    track_1.save
    track_2.created_at = Time.zone.parse("2014-1-20 3pm")
    track_2.start_time = Time.zone.parse("2014-1-23 5pm")
    track_2.end_time = Time.zone.parse("2014-1-23 8pm")
    track_2.save

    # 3D ratings array holds n (10-11) ratings per student (up to 8) per date (3)
    # Rating creation checks for nil score entries and if so doesn't create rating
    myscores = [[[]]]
    myscores[0] = [ [  1,  0,  1,  1,  0,  0,nil,nil,nil,nil, 1],
                     [  1,  0,  1,nil,nil,nil,nil,  0,  1,  1, 0],
                     [  0,  1,  0,  1,  0,  1,  0,  1,  1,  1, 0],
                     [nil,nil,nil,nil,nil,  0,  0,  0,  0,  0, 1],
                     [  1,  0,  1,  1,  0,  0,nil,nil,  1,nil, nil],
                     [  0,  1,  0,nil,nil,nil,nil,  0,  1,  1, nil],
                     [  1,  0,  1,  0,  1,  0,  0,  nil,1,  1, 0],
                     [  1,nil,1,nil,nil,  1,  0,  0,  0,  1, 0]]
    myscores[1] = [ [  2,  0,  1,  1,  2,  0,nil,nil,1, 2, 1],
                     [  1,  1,  1, 2,nil,nil, 2,  0,  1,  1, 0],
                     [  1,  1,  1,  2,  0,  1,  2,  1,  2,  1, 1],
                     [  1,  1,  1,  1,  1,  0,  0,  0,  0,  0, 1],
                     [  1,  1,  1,  1,  1,  1,  2,  2,  1,  2, nil],
                     [  1,  2,  1,  1,  1,  1,  1,  1,  1,  1, nil],
                     [  1,  0,  1,  0,  1,  0,  0,  nil,1,  1, 0],
                     [  2,nil,1,nil,nil,  1,  0,  0,  0,  1, 0]]
    myscores[2] = [ [  nil,  2,  2,  2,  nil,  2,nil,nil,2, nil, 2],
                     [  2,  2,  2, nil ,  1,  1, 2,  1,  2,  1, 1],
                     [  2,  2,  1,  nil,  1,  2,  nil,  2,  nil,  1, 2],
                     [  2,  2,  1,  2,  2,  1,  1,  1,  1,  1, 1],
                     [  2,  2,  2,  2,  2,  1,  2,  2,  1,  2, 1],
                     [  1,  2,  2,  2,  2,  2,  2,  1,  1,  1, 1],
                     [  1,  2,  2,  2,  2,  2,  2,  2,2,  1, 1],
                     [  2,  2,  1,  2,  2,  1,  1,  1,  1,  2, 2]]
    num_ratings = myscores[0][0].length

    num_ratings.times {|i|
      num_students.times {|j|
        mydates.length.times {|k|
         student_roles[j].ratings.create(checkpoint: track_1_checkpoints[i], score: myscores[k][j][i], created_at: mydates[k]) if myscores[k][j][i]}}}

    myscores[0] = [ [  0,  1,  1,  0,  nil,  1,nil,nil,nil,1],
                     [  1,  1,  0,nil,nil, 0,nil,  0,  nil,  1],
                     [  0,  0,  0,  1,  1,  0,  0,  1,  0,  1],
                     [nil,0,nil,nil,nil,  0,  0,  nil,  0,  nil],
                     [  0,  0,  1,  0,  0,  0,0,nil,  nil,nil],
                     [  0,  0,  0,  0,nil,nil, 0,  0,  1,  1],
                     [  0,  0,  nil,  0,  1,  0,  0,  nil,0,  1],
                     [  0,  0, 1,nil ,0,  1,  0,  nil,  0,  0]]
    myscores[1] = [ [  1,  2,  2,  0,   1,  1,  1,  1,  1,2],
                     [  nil,  1,  1,  1,  1, 0,  1,  0,    2,  1],
                     [  0,  1,  2,  2,  1,  1,  1,  1,  2,  1],
                     [  1, 1,  1,  2,  1,   1,   2,    1,   1, 0],
                     [  1,  1,  2,  1,  1,  0, 0,2,  2, 1],
                     [  0,  1,  1,  1, 2, 2, 0,  1,  2,  1],
                     [  2,  1,  1,  1,  1,  2,  1,  1,0,  1],
                     [  0,  1, 1, 2 ,1,  2,  0,  2,  1,  1]]
    myscores[2] = [ [  2,  nil,  nil,  1,   2,  2,  2,  1,  2,nil],
                     [  1,  1,  2,  2,  2, 0,  1,  2,    2,  2],
                     [  2,  1,  nil,  nil,  1,  2,  1,  2,  nil,  12],
                     [  1, 2,  1,  2,  1,   2,   2,    1,   1, 2],
                     [  2,  1,  2,  1,  1,  1, 1,nil,  nil, 1],
                     [  0,  2,  2,  2, 2, 2, 1,  1,  2,  1],
                     [  2,  1,  2,  2,  2,  2,  1,  1,1,  1],
                     [  1,  1, 2, 2 ,2,  2,  2,  2,  1,  1]]
    num_ratings = myscores[0][0].length

    num_ratings.times {|i|
      num_students.times {|j|
        mydates.length.times {|k|
         Student.find(students[j].classrole_id).ratings.create(checkpoint: track_2_checkpoints[i], score: myscores[k][j][i], created_at: mydates2[k]) if myscores[k][j][i]}}}
  end
end
def add_second_sample_classroom(teacher)
  default_classroom = teacher.classrooms.create(name: "Introduction to Statistics")
  track_1 = default_classroom.tracks.create(name: "Track 1: Introduction and Terminology", published: true)
  track_2 = default_classroom.tracks.create(name: "Track 2: Visualizing data; Mean, Median and Mode", published: true)

  track_1.checkpoints.create([
    {expectation: "Population vs Sample", success_criteria: "Population = all individuals in a group; sample = some (often randomly selected) subset of these individuals."},
    {expectation: "Parameter vs Statistic", success_criteria: "Parameter: describes a characteristic of the population; statistic: a characteristic of the sample."},
    {expectation: "Sampling Error", success_criteria: "Difference between sample mean (x̄) and population mean (µ)"},
    {expectation: "A construct", success_criteria: "E.g. how hungry someone is. Not something precise and defined with units, e.g. not fuel efficiency in mpg. Something difficult to measure because it can be defined in many ways."},
    {expectation: "Operational definition", success_criteria: "A way to turn concepts into a measurable variable; a way of describing a variable in terms of the way we measure it."},
    {expectation: "Experimental vs Observational", success_criteria: "Design/apply treatments in a controlled study and study different results of different treatments; vs watching subjects (nature, society, etc) and not introducing treatments."},
    {expectation: "Treatment Group vs Control Group", success_criteria: "The set of individuals in a study receiving a certain treatment vs. the set receiving no treatment, to have a baseline to compare to."},
    {expectation: "Hypotheses", success_criteria: "Statements about the relationships between variables to be tested by analyzing data."},
    {expectation: "Extraneous/lurking variables", success_criteria:  "Factors that could provide possible alternative explanations for observed relationships between variables; things we should try to control for."},
    {expectation: "Blinded Study", success_criteria:  "Blinded study: participants don't know if they are in Treatment or Control group. Double blind: neither researchers nor participants know who's in which group."},
    {expectation: "Independent vs Dependent Variable", success_criteria:  "Independent: the variable experimenters choose to manipulate, usually represented by the horizontal (x) axis; Dependent, the measured variable, usually represented by the vertical (y) axis."}])

  track_2.checkpoints.create([
    {expectation: "Frequency, Proportion, and Percentage", success_criteria: "Frequency = number of times a particular outcome (eg a test score of 90 to 95) occurs. A proportion = a frequency / total sample. We can express a proportion as a percentage by multiplying by 100."},
    {expectation: "Histogram", success_criteria: "Used if data along x-axis is numerical; graphical representation of a distribution, made of adjacent rectangles with height = frequency of occurrence of data in the interval (bin) represented by width"},
    {expectation: "Bar Graph", success_criteria: "Similar to a histogram, bar graphs, with a slight spacing between bars, are used when the data is categorical."},
    {expectation: "Positively skewed distribution", success_criteria: "A peak on the left hand side of the distribution dies off down to outliers as one goes to the right."},
    {expectation: "Negatively skewed distribution", success_criteria: "Low frequencies on the left hand side of the distribution grow to a peak on the right hand side of the distribution. Example, age at retirement."},
    {expectation: "Mode", success_criteria: "Most frequent score (the value of x of the highest bar in a histogram). Unaffected by outliers."},
    {expectation: "Median", success_criteria: "The middle of the distribution. Also insensitive to outliers. If two numbers are in the middle (i.e. an even number of data points), the median is the average of these two."},
    {expectation: "Mean", success_criteria: "(x1 + x2 + … + xn)/n;
What we commonly refer to as the average. Thrown off by outliers."},
    {expectation: "Comparing mean, median, mode: normal distribution", success_criteria: "For a normal distribution (bell curve), mean = median = mode."},
    {expectation: "Comparing mean, median, mode: skewed distributions", success_criteria: "For a positively skewed distribution (peak near the y axis) mode < median < mean. The reverse is true for negatively skewed. Mnemonic: the median is always in the middle."}
    ])
end
make_accounts("teacher1@fakemail.com", ["student1@fakemail.com", "student2@fakemail.com", "student3@fakemail.com", "student4@fakemail.com"], "1234")
make_accounts("teacher@mail.com", ["student1@mail.com", "student2@mail.com", "student3@mail.com", "student4@mail.com",
  "student5@mail.com", "student6@mail.com", "student7@mail.com", "student8@mail.com"], "abcd")
make_accounts("teacher1@mail.com", ["student_1@mail.com", "student_2@mail.com", "student_3@mail.com", "student_4@mail.com"], "defg")
addStatsCourse("teacher1@fakemail.com", ["student1@fakemail.com", "student2@fakemail.com", "student3@fakemail.com", "student4@fakemail.com"])
addStatsCourse("teacher1@mail.com", ["student_1@mail.com", "student_2@mail.com", "student_3@mail.com", "student_4@mail.com"])