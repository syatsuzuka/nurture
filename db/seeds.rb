# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def user_count(role)
  User.where(role: role).count
end

puts 'Cleaning up progress...'
Progress.destroy_all
puts 'Cleaning up target...'
Target.destroy_all
puts 'Cleaning up message...'
Message.destroy_all
puts 'Cleaning up chartroom...'
Chatroom.destroy_all
puts 'Cleaning up assignments...'
Assignment.destroy_all
puts 'Cleaning up courses...'
Course.destroy_all
puts 'Cleaning up users...'
User.destroy_all

puts '===================================='
puts "Generating personal tutor seeds..."

tutor_1 = User.create!(email: 'shingo@mail.com', first_name: 'Shingo', last_name: 'Kubomura', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
tutor_2 = User.create!(email: 'ed@mail.com', first_name: 'Ed', last_name: 'Oz', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
tutor_3 = User.create!(email: 'shunjiro@mail.com', first_name: 'Shunjiro', last_name: 'Yatsuzuka', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
tutor_4 = User.create!(email: 'doug@mail.com',nickname:"Doug", first_name: 'Dougn', last_name: 'Berkeley', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
tutor_5 = User.create!(email: 'tutor@mail.com',nickname:"1234", first_name: 'Teachy', last_name: 'McTeacherson', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")

puts "Generating random tutor seeds..."

5.times do
  User.create(email: "#{Faker::Internet.email}",
              first_name: "#{Faker::Name.name.split[0]}",
              last_name: "#{Faker::Name.name.split[1]}",
              password: '11221122', role: 'tutor',
              avatar_url: "#{Faker::LoremPixel.image}")
end

puts "Generated #{user_count("tutor")} #{Faker::Emotion.adjective} new tutors"

puts '===================================='
puts "#{Faker::Hacker.ingverb} personal student seeds..."

student_1 = User.create!(email: 'shingos@mail.com', first_name: 'Shingo', last_name: 'Kubomura', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")
student_2 = User.create!(email: 'eds@mail.com', first_name: 'Ed', last_name: 'Oz', password: '11221122', role: 'student')
student_3 = User.create!(email: 'shunjiros@mail.com', first_name: 'Shunjiro', last_name: 'Yatsuzuka', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")
student_4 = User.create!(email: 'tutors@mail.com',nickname: "1234", first_name: 'Teachy', last_name: 'McTeacherson', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")

puts "Generating random student seeds..."

15.times do
  User.create(email: "#{Faker::Internet.email}",
              first_name: "#{Faker::Name.name.split[0]}",
              last_name: "#{Faker::Name.name.split[1]}",
              password: '11221122',
              role: 'student',
              avatar_url: "#{Faker::LoremPixel.image}")
end

puts "Generated #{user_count("student")} #{Faker::Emotion.adjective} new students"
puts '===================================='


puts '===================================='
puts "Generating courses..."
course_1 = Course.create!(name: "Tennis Lesson (Entry Level)", description: "Private Tennis Lesson to help to win the junior high school student's championship.", tutor_user_id: tutor_4.id, student_user_id: student_3.id )
chatroom_1 = Chatroom.create!(name: "Assignment chat")

course_2 = Course.create!(name: "English Lesson for TOEFL", description: "Private tutoring in English to get higher score in TOEFL exam.", tutor_user_id: tutor_4.id, student_user_id: student_3.id )
chatroom_2 = Chatroom.create!(name: "Assignment chat")

course_3 = Course.create!(name: "Private Trainer for Weight Loss", description: "Private training to help for weight loss.", tutor_user_id: tutor_4.id, student_user_id: student_3.id )
chatroom_3 = Chatroom.create!(name: "Assignment chat")

20.times do
  Course.create(name: "#{Faker::JapaneseMedia::Doraemon.gadget}-101", description: "#{Faker::Movies::Lebowski.quote}", tutor_user_id: User.where(role:"tutor").sample.id, student_user_id: User.where(role: "student").sample.id )
  Chatroom.create(name: "Assignment chat")
end

puts "Generated #{Course.all.count} courses successfully"

puts '===================================='
puts 'Generating assignments...'

assignment_11 = Assignment.create!(title: "Self Practice of Serve", instruction: "Practice Serve repeatedly to raise the success rate of Serve", comment: "", checkpoint: "Achieve 80% success rate in self practices", course_id: course_1.id, status: 0, start_date: "2022-04-01", end_date: "2022-05-31")
assignment_12 = Assignment.create!(title: "Mustle Training (Shoulder Press)", instruction: "Ramp up mastle of shoulder to make faster and stable Serve", comment: "", checkpoint: "Have 5 sets of 10 times every two days", course_id: course_1.id, status: 0, start_date: "2022-05-01", end_date: "2022-06-30")

assignment_21 = Assignment.create!(title: "Listening Practice with English Journal", instruction: "Take 30mins to listen English Journey every day", comment: "", checkpoint: "Take 30mins every days", course_id: course_2.id, status: 0, start_date: "2022-04-01", end_date: "2022-05-31")
assignment_22 = Assignment.create!(title: "Enhance vocabrary", instruction: "Check 10 new words every days and memorize them", comment: "", checkpoint: "Memorize 70% of new words", course_id: course_2.id, status: 0, start_date: "2022-05-01", end_date: "2022-06-30")

30.times do
  title= "#{Faker::Verb.ing_form.capitalize} practice"
  checkpoint= "can #{Faker::Verb.base} #{rand(100)} times in a row"
  instruction = "#{Faker::Quote.yoda}"
  comment = "#{Faker::Quote.robin}"
  status = rand(3)
  Assignment.create(title: title, instruction: instruction, comment: comment, checkpoint: checkpoint, course_id: Course.all.sample.id, status: status, start_date: Random.rand(Time.zone.today.last_year..Time.zone.today), end_date: Random.rand(Time.zone.tomorrow..Time.zone.tomorrow.next_year))
end

puts "Generated #{Assignment.all.count} Assignments successfully"

puts '===================================='
puts 'Generating targets...'
target_1 = Target.create!(name: "Service Ace Rate (%)", description: "Achieve higher successful rate in Serviece Ace.", score: 20, course_id: course_1.id, display: true )
target_2 = Target.create!(name: "Return Ace Rate (%)", description: "Achieve higher successful rate in Return Ace.", score: 10, course_id: course_1.id, display: true )
target_3 = Target.create!(name: "Double Fault Rate (%)", description: "Achieve less failure rate in Double Fault.", score: 20, course_id: course_1.id, display: true )

target_11 = Target.create!(name: "Reading", description: "Achieve higher score in Reading.", score: 25, course_id: course_2.id, display: true )
target_12 = Target.create!(name: "Listening", description: "Achieve higher score in Listening.", score: 25, course_id: course_2.id, display: true )
target_13 = Target.create!(name: "Speaking", description: "Achieve higher score in Speaking.", score: 25, course_id: course_2.id, display: true )
target_14 = Target.create!(name: "Writing", description: "Achieve higher score in Writing.", score: 25, course_id: course_2.id, display: true )

puts "Generated #{Target.all.count} Targets successfully"

puts '===================================='
puts 'Generating progresses...'

progress_11 = Progress.create!(date: "2021-09-01", score: 13, target_id: target_1.id, comment: "the score in official game with Mike of ABC junior high school")
progress_12 = Progress.create!(date: "2021-10-01", score: 15, target_id: target_1.id, comment: "the score in private game with John of the same junior high school")
progress_13 = Progress.create!(date: "2021-11-01", score: 14, target_id: target_1.id, comment: "the score in championship league")
progress_14 = Progress.create!(date: "2021-12-01", score: 16, target_id: target_1.id, comment: "the score in official game with Mike of ABC junior high school")
progress_15 = Progress.create!(date: "2022-01-01", score: 17, target_id: target_1.id, comment: "the score in private game with John of the same junior high school")
progress_16 = Progress.create!(date: "2022-02-01", score: 19, target_id: target_1.id, comment: "the score in championship league")
progress_17 = Progress.create!(date: "2022-03-01", score: 21, target_id: target_1.id, comment: "the score in official game with Mike of ABC junior high school")
progress_18 = Progress.create!(date: "2022-04-01", score: 18, target_id: target_1.id, comment: "the score in private game with John of the same junior high school")
progress_19 = Progress.create!(date: "2022-05-01", score: 20, target_id: target_1.id, comment: "the score in championship league")

progress_21 = Progress.create!(date: "2021-09-01", score: 8, target_id: target_2.id, comment: "the score in official game with Mike of ABC junior high school")
progress_22 = Progress.create!(date: "2021-10-01", score: 9, target_id: target_2.id, comment: "the score in private game with John of the same junior high school")
progress_23 = Progress.create!(date: "2021-11-01", score: 10.5, target_id: target_2.id, comment: "the score in championship league")
progress_24 = Progress.create!(date: "2021-12-01", score: 11, target_id: target_2.id, comment: "the score in official game with Mike of ABC junior high school")
progress_25 = Progress.create!(date: "2022-01-01", score: 13, target_id: target_2.id, comment: "the score in private game with John of the same junior high school")
progress_26 = Progress.create!(date: "2022-02-01", score: 10.5, target_id: target_2.id, comment: "the score in championship league")
progress_27 = Progress.create!(date: "2022-03-01", score: 11, target_id: target_2.id, comment: "the score in official game with Mike of ABC junior high school")
progress_28 = Progress.create!(date: "2022-04-01", score: 10, target_id: target_2.id, comment: "the score in private game with John of the same junior high school")
progress_29 = Progress.create!(date: "2022-05-01", score: 10.5, target_id: target_2.id, comment: "the score in championship league")

progress_111 = Progress.create!(date: "2021-09-01", score: 20, target_id: target_11.id, comment: "official TOEFL exam")
progress_112 = Progress.create!(date: "2021-10-01", score: 21, target_id: target_11.id, comment: "official TOEFL exam")
progress_113 = Progress.create!(date: "2021-11-01", score: 22, target_id: target_11.id, comment: "mock TOEFL exam")
progress_114 = Progress.create!(date: "2021-12-01", score: 23, target_id: target_11.id, comment: "official TOEFL exam")
progress_115 = Progress.create!(date: "2022-01-01", score: 25, target_id: target_11.id, comment: "official TOEFL exam")
progress_116 = Progress.create!(date: "2022-02-01", score: 24, target_id: target_11.id, comment: "mock TOEFL exam")
progress_117 = Progress.create!(date: "2022-03-01", score: 25, target_id: target_11.id, comment: "official TOEFL exam")
progress_118 = Progress.create!(date: "2022-04-01", score: 26, target_id: target_11.id, comment: "official TOEFL exam")
progress_119 = Progress.create!(date: "2022-05-01", score: 27, target_id: target_11.id, comment: "mock TOEFL exam")

progress_121 = Progress.create!(date: "2021-09-01", score: 18, target_id: target_12.id, comment: "official TOEFL exam")
progress_122 = Progress.create!(date: "2021-10-01", score: 17, target_id: target_12.id, comment: "official TOEFL exam")
progress_123 = Progress.create!(date: "2021-11-01", score: 21, target_id: target_12.id, comment: "mock TOEFL exam")
progress_124 = Progress.create!(date: "2021-12-01", score: 18, target_id: target_12.id, comment: "official TOEFL exam")
progress_125 = Progress.create!(date: "2022-01-01", score: 17, target_id: target_12.id, comment: "official TOEFL exam")
progress_126 = Progress.create!(date: "2022-02-01", score: 21, target_id: target_12.id, comment: "mock TOEFL exam")
progress_127 = Progress.create!(date: "2022-03-01", score: 18, target_id: target_12.id, comment: "official TOEFL exam")
progress_128 = Progress.create!(date: "2022-04-01", score: 17, target_id: target_12.id, comment: "official TOEFL exam")
progress_129 = Progress.create!(date: "2022-05-01", score: 21, target_id: target_12.id, comment: "mock TOEFL exam")

progress_131 = Progress.create!(date: "2021-09-01", score: 16, target_id: target_13.id, comment: "official TOEFL exam")
progress_132 = Progress.create!(date: "2021-10-01", score: 15, target_id: target_13.id, comment: "official TOEFL exam")
progress_133 = Progress.create!(date: "2021-11-01", score: 18, target_id: target_13.id, comment: "mock TOEFL exam")
progress_134 = Progress.create!(date: "2021-12-01", score: 16, target_id: target_13.id, comment: "official TOEFL exam")
progress_135 = Progress.create!(date: "2022-01-01", score: 15, target_id: target_13.id, comment: "official TOEFL exam")
progress_136 = Progress.create!(date: "2022-02-01", score: 16, target_id: target_13.id, comment: "mock TOEFL exam")
progress_137 = Progress.create!(date: "2022-03-01", score: 17, target_id: target_13.id, comment: "official TOEFL exam")
progress_138 = Progress.create!(date: "2022-04-01", score: 15, target_id: target_13.id, comment: "official TOEFL exam")
progress_139 = Progress.create!(date: "2022-05-01", score: 18, target_id: target_13.id, comment: "mock TOEFL exam")

progress_141 = Progress.create!(date: "2021-09-01", score: 23, target_id: target_14.id, comment: "official TOEFL exam")
progress_142 = Progress.create!(date: "2021-10-01", score: 25, target_id: target_14.id, comment: "official TOEFL exam")
progress_143 = Progress.create!(date: "2021-11-01", score: 24, target_id: target_14.id, comment: "mock TOEFL exam")
progress_144 = Progress.create!(date: "2021-12-01", score: 26, target_id: target_14.id, comment: "official TOEFL exam")
progress_145 = Progress.create!(date: "2022-01-01", score: 25, target_id: target_14.id, comment: "official TOEFL exam")
progress_146 = Progress.create!(date: "2022-02-01", score: 26, target_id: target_14.id, comment: "mock TOEFL exam")
progress_147 = Progress.create!(date: "2022-03-01", score: 26, target_id: target_14.id, comment: "official TOEFL exam")
progress_148 = Progress.create!(date: "2022-04-01", score: 27, target_id: target_14.id, comment: "official TOEFL exam")
progress_149 = Progress.create!(date: "2022-05-01", score: 28, target_id: target_14.id, comment: "mock TOEFL exam")

puts "Generated #{Progress.all.count} Progresses successfully"

puts "Remember :#{Faker::Marketing.buzzwords}"
