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

tutor_1 = User.create!(email: 'shingo@mail.com', nickname: "shingo", first_name: 'Shingo', last_name: 'Kubomura', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
tutor_2 = User.create!(email: 'ed@mail.com', nickname: "ed", first_name: 'Ed', last_name: 'Oz', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
tutor_3 = User.create!(email: 'shunjiro@mail.com', nickname: "shunjiro", first_name: 'Shunjiro', last_name: 'Yatsuzuka', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
tutor_4 = User.create!(email: 'james@mail.com', nickname: "james", first_name: 'James', last_name: 'Reed', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
tutor_5 = User.create!(email: 'tutor@mail.com', nickname: "tutor", first_name: 'Taro', last_name: 'Yamada', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")

puts "Generating random tutor seeds..."

# 5.times do
#   User.create(email: "#{Faker::Internet.email}",
#               first_name: "#{Faker::Name.name.split[0]}",
#               last_name: "#{Faker::Name.name.split[1]}",
#               password: '11221122', role: 'tutor',
#               avatar_url: "#{Faker::LoremPixel.image}")
# end

puts "Generated #{user_count("tutor")} #{Faker::Emotion.adjective} new tutors"

puts '===================================='
puts "#{Faker::Hacker.ingverb} personal student seeds..."

student_1 = User.create!(email: 'shingos@mail.com', nickname: "shingo", first_name: 'Shingo', last_name: 'Kubomura', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")
# student_2 = User.create!(email: 'eds@mail.com', nickname: "ed", first_name: 'Ed', last_name: 'Oz', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")
student_3 = User.create!(email: 'shunjiros@mail.com', nickname: "shunjiro", first_name: 'Shunjiro', last_name: 'Yatsuzuka', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")
student_4 = User.create!(email: 'jamess@mail.com',nickname: "james", first_name: 'James', last_name: 'Reed', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")
student_5 = User.create!(email: 'student@mail.com',nickname: "student", first_name: 'Taro', last_name: 'Yamada', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")

puts "Generating random student seeds..."

# 15.times do
#   User.create(email: "#{Faker::Internet.email}",
#               first_name: "#{Faker::Name.name.split[0]}",
#               last_name: "#{Faker::Name.name.split[1]}",
#               password: '11221122',
#               role: 'student',
#               avatar_url: "#{Faker::LoremPixel.image}")
# end

puts "Generated #{user_count("student")} #{Faker::Emotion.adjective} new students"
puts '===================================='


puts '===================================='
puts "Generating courses..."
course_11 = Course.create!(name: "Tennis Lesson (Beginner)", description: "Private Tennis Lesson for complete beginners.", tutor_user_id: tutor_2.id, student_user_id: student_1.id )
chatroom_11 = Chatroom.create!(name: "Assignment chat")

course_1 = Course.create!(name: "Tennis Lesson (Intermediate)", description: "Private Tennis Lesson to help to win the junior high school student's championship.", tutor_user_id: tutor_2.id, student_user_id: student_1.id )
chatroom_1 = Chatroom.create!(name: "Assignment chat")

# course_2 = Course.create!(name: "Tennis Lesson (Intermediate)", description: "Private Tennis Lesson to help to win the junior high school student's championship.", tutor_user_id: tutor_2.id, student_user_id: student_2.id )
# chatroom_2 = Chatroom.create!(name: "Assignment chat")

course_3 = Course.create!(name: "Tennis Lesson (Intermediate)", description: "Private Tennis Lesson to help to win the junior high school student's championship.", tutor_user_id: tutor_2.id, student_user_id: student_3.id )
chatroom_3 = Chatroom.create!(name: "Assignment chat")

course_21 = Course.create!(name: "Tennis Lesson (Advanced)", description: "Private Tennis Lesson to win the national championship.", tutor_user_id: tutor_2.id, student_user_id: student_4.id )
chatroom_21 = Chatroom.create!(name: "Assignment chat")

course_31 = Course.create!(name: "English Lesson for TOEFL", description: "Private tutoring in English to get higher score in TOEFL exam.", tutor_user_id: tutor_3.id, student_user_id: student_3.id )
chatroom_31 = Chatroom.create!(name: "Assignment chat")



# 20.times do
#   Course.create(name: "#{Faker::JapaneseMedia::Doraemon.gadget}-101", description: "#{Faker::Movies::Lebowski.quote}", tutor_user_id: User.where(role:"tutor").sample.id, student_user_id: User.where(role: "student").sample.id )
#   Chatroom.create(name: "Assignment chat")
# end

puts "Generated #{Course.all.count} courses successfully"

puts '===================================='
puts 'Generating assignments...'

# assignment_11 = Assignment.create!(title: "Self Practice of Serve", instruction: "Practice Serve repeatedly to raise the success rate of Serve", comment: "", checkpoint: "Achieve 80% success rate in self practices", course_id: course_1.id, status: 0, start_date: "2022-04-01", end_date: "2022-05-31")
assignment_11 = Assignment.create!(title: "Smash Practice", instruction: "Practice Smash with machine", comment: "", checkpoint: "Have 5 sets of 10 times every two days", course_id: course_1.id, status: 2, start_date: "2022-01-01", end_date: "2022-03-31")
# assignment_21 = Assignment.create!(title: "Smash Practice", instruction: "Practice Smash with machine", comment: "", checkpoint: "Have 5 sets of 10 times every two days", course_id: course_2.id, status: 2, start_date: "2022-01-01", end_date: "2022-03-31")
assignment_31 = Assignment.create!(title: "Smash Practice", instruction: "Practice Smash with machine", comment: "", checkpoint: "Have 5 sets of 10 times every two days", course_id: course_3.id, status: 2, start_date: "2022-01-01", end_date: "2022-03-31")

assignment_111 = Assignment.create!(title: "Swing Practice every day", instruction: "Take 30mins for shadow swing everyday", comment: "", checkpoint: "Take 60mins every days", course_id: course_11.id, status: 2, start_date: "2020-09-01", end_date: "2020-12-31")

assignment_211 = Assignment.create!(title: "Mustle Training (Shoulder Press)", instruction: "Ramp up mastle of shoulder to make faster and stable Serve", comment: "", checkpoint: "Have 5 sets of 10 times every two days", course_id: course_21.id, status: 0, start_date: "2022-04-01", end_date: "2022-06-12")

assignment_311 = Assignment.create!(title: "Listening Practice with English Journal", instruction: "Take 30mins to listen English Journey every day", comment: "", checkpoint: "Take 30mins every days", course_id: course_31.id, status: 0, start_date: "2022-04-01", end_date: "2022-05-31")
assignment_312 = Assignment.create!(title: "Enhance vocabrary", instruction: "Check 10 new words every days and memorize them", comment: "", checkpoint: "Memorize 70% of new words", course_id: course_31.id, status: 0, start_date: "2022-05-01", end_date: "2022-06-30")


# 30.times do
#   title= "#{Faker::Verb.ing_form.capitalize} practice"
#   checkpoint= "can #{Faker::Verb.base} #{rand(100)} times in a row"
#   instruction = "#{Faker::Quote.yoda}"
#   comment = "#{Faker::Quote.robin}"
#   status = rand(3)
#   Assignment.create(title: title, instruction: instruction, comment: comment, checkpoint: checkpoint, course_id: Course.all.sample.id, status: status, start_date: Random.rand(Time.zone.today.last_year..Time.zone.today), end_date: Random.rand(Time.zone.tomorrow..Time.zone.tomorrow.next_year))
# end

puts "Generated #{Assignment.all.count} Assignments successfully"

puts '===================================='
puts 'Generating targets...'
target_11 = Target.create!(name: "Service Ace Rate (%)", description: "Achieve higher successful rate in Serviece Ace.", score: 30, course_id: course_1.id, display: true )
target_12 = Target.create!(name: "Return Ace Rate (%)", description: "Achieve higher successful rate in Return Ace.", score: 10, course_id: course_1.id, display: true )
# target_21 = Target.create!(name: "Service Ace Rate (%)", description: "Achieve higher successful rate in Serviece Ace.", score: 30, course_id: course_2.id, display: true )
# target_22 = Target.create!(name: "Return Ace Rate (%)", description: "Achieve higher successful rate in Return Ace.", score: 10, course_id: course_2.id, display: true )
target_31 = Target.create!(name: "Service Ace Rate (%)", description: "Achieve higher successful rate in Serviece Ace.", score: 30, course_id: course_3.id, display: true )
target_32 = Target.create!(name: "Return Ace Rate (%)", description: "Achieve higher successful rate in Return Ace.", score: 10, course_id: course_3.id, display: true )
# target_3 = Target.create!(name: "Double Fault Rate (%)", description: "Achieve less failure rate in Double Fault.", score: 20, course_id: course_1.id, display: true )

target_111 = Target.create!(name: "Forhand Stroke (%)", description: "Achieve higher successful rate in Forehand Stroke.", score: 40, course_id: course_11.id, display: true )
target_112 = Target.create!(name: "Backhand Stroke (%)", description: "Achieve higher successful rate in Backhand Stroke.", score: 20, course_id: course_11.id, display: true )

target_211 = Target.create!(name: "Smash Success Rate (%)", description: "Achieve higher successful rate in Smash.", score: 30, course_id: course_21.id, display: true )

target_311 = Target.create!(name: "Reading", description: "Achieve higher score in Reading.", score: 25, course_id: course_31.id, display: true )
target_312 = Target.create!(name: "Listening", description: "Achieve higher score in Listening.", score: 25, course_id: course_31.id, display: true )
target_313 = Target.create!(name: "Speaking", description: "Achieve higher score in Speaking.", score: 25, course_id: course_31.id, display: true )
target_314 = Target.create!(name: "Writing", description: "Achieve higher score in Writing.", score: 25, course_id: course_31.id, display: true )

puts "Generated #{Target.all.count} Targets successfully"

puts '===================================='
puts 'Generating progresses...'

# Tennis Lesson (Intermediate) - shingos
progress_111 = Progress.create!(date: "2020-12-01", score: 16 + rand(8)-4, target_id: target_11.id, comment: "the score in official game with Mike of ABC junior high school")
progress_112 = Progress.create!(date: "2021-01-01", score: 16.5 + rand(8)-4, target_id: target_11.id, comment: "the score in private game with John of the same junior high school")
progress_113 = Progress.create!(date: "2021-02-01", score: 17 + rand(8)-4, target_id: target_11.id, comment: "the score in championship league")
progress_114 = Progress.create!(date: "2021-03-01", score: 17.5 + rand(8)-4, target_id: target_11.id, comment: "the score in official game with Mike of ABC junior high school")
progress_115 = Progress.create!(date: "2021-04-01", score: 18 + rand(8)-4, target_id: target_11.id, comment: "the score in private game with John of the same junior high school")
progress_116 = Progress.create!(date: "2021-05-01", score: 18.5 + rand(8)-4, target_id: target_11.id, comment: "the score in championship league")
progress_117 = Progress.create!(date: "2021-06-01", score: 19 + rand(8)-4, target_id: target_11.id, comment: "the score in official game with Mike of ABC junior high school")
progress_118 = Progress.create!(date: "2021-07-01", score: 19.5 + rand(8)-4, target_id: target_11.id, comment: "the score in private game with John of the same junior high school")
progress_119 = Progress.create!(date: "2021-08-01", score: 20 + rand(8)-4, target_id: target_11.id, comment: "the score in championship league")
progress_1111 = Progress.create!(date: "2021-09-01", score: 20.5 + rand(8)-4, target_id: target_11.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1112 = Progress.create!(date: "2021-10-01", score: 21 + rand(8)-4, target_id: target_11.id, comment: "the score in private game with John of the same junior high school")
progress_1113 = Progress.create!(date: "2021-11-01", score: 21 + rand(8)-4, target_id: target_11.id, comment: "the score in championship league")
progress_1114 = Progress.create!(date: "2021-12-01", score: 21 + rand(8)-4, target_id: target_11.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1115 = Progress.create!(date: "2022-01-01", score: 21 + rand(8)-4, target_id: target_11.id, comment: "the score in private game with John of the same junior high school")
progress_1116 = Progress.create!(date: "2022-02-01", score: 21 + rand(8)-4, target_id: target_11.id, comment: "the score in championship league")
progress_1117 = Progress.create!(date: "2022-03-01", score: 21 + rand(8)-4, target_id: target_11.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1118 = Progress.create!(date: "2022-04-01", score: 21 + rand(8)-4, target_id: target_11.id, comment: "the score in private game with John of the same junior high school")
progress_1119 = Progress.create!(date: "2022-05-01", score: 21 + rand(8)-4, target_id: target_11.id, comment: "the score in championship league")

progress_121 = Progress.create!(date: "2020-12-01", score: 3.5 + rand(8)-4, target_id: target_12.id, comment: "the score in official game with Mike of ABC junior high school")
progress_122 = Progress.create!(date: "2021-01-01", score: 4 + rand(8)-4, target_id: target_12.id, comment: "the score in private game with John of the same junior high school")
progress_123 = Progress.create!(date: "2021-02-01", score: 4.5 + rand(8)-4, target_id: target_12.id, comment: "the score in championship league")
progress_124 = Progress.create!(date: "2021-03-01", score: 5.5 + rand(8)-4, target_id: target_12.id, comment: "the score in official game with Mike of ABC junior high school")
progress_125 = Progress.create!(date: "2021-04-01", score: 5.5 + rand(8)-4, target_id: target_12.id, comment: "the score in private game with John of the same junior high school")
progress_126 = Progress.create!(date: "2021-05-01", score: 6 + rand(8)-4, target_id: target_12.id, comment: "the score in championship league")
progress_127 = Progress.create!(date: "2021-06-01", score: 6.5 + rand(8)-4, target_id: target_12.id, comment: "the score in official game with Mike of ABC junior high school")
progress_128 = Progress.create!(date: "2021-07-01", score: 7 + rand(8)-4, target_id: target_12.id, comment: "the score in private game with John of the same junior high school")
progress_129 = Progress.create!(date: "2021-08-01", score: 7.5 + rand(8)-4, target_id: target_12.id, comment: "the score in championship league")
progress_1211 = Progress.create!(date: "2021-09-01", score: 8 + rand(8)-4, target_id: target_12.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1212 = Progress.create!(date: "2021-10-01", score: 8.5 + rand(8)-4, target_id: target_12.id, comment: "the score in private game with John of the same junior high school")
progress_1213 = Progress.create!(date: "2021-11-01", score: 9 + rand(8)-4, target_id: target_12.id, comment: "the score in championship league")
progress_1214 = Progress.create!(date: "2021-12-01", score: 9.5 + rand(8)-4, target_id: target_12.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1215 = Progress.create!(date: "2022-01-01", score: 10 + rand(8)-4, target_id: target_12.id, comment: "the score in private game with John of the same junior high school")
progress_1216 = Progress.create!(date: "2022-02-01", score: 10.5 + rand(8)-4, target_id: target_12.id, comment: "the score in championship league")
progress_1217 = Progress.create!(date: "2022-03-01", score: 11 + rand(8)-4, target_id: target_12.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1218 = Progress.create!(date: "2022-04-01", score: 11.5 + rand(8)-4, target_id: target_12.id, comment: "the score in private game with John of the same junior high school")
progress_1219 = Progress.create!(date: "2022-05-01", score: 12 + rand(8)-4, target_id: target_12.id, comment: "the score in championship league")

# progress_211 = Progress.create!(date: "2021-09-01", score: progress_111.score + rand(8)-4, target_id: target_21.id, comment: "the score in official game with Mike of ABC junior high school")
# progress_212 = Progress.create!(date: "2021-10-01", score: progress_112.score + rand(8)-4, target_id: target_21.id, comment: "the score in private game with John of the same junior high school")
# progress_213 = Progress.create!(date: "2021-11-01", score: progress_113.score + rand(8)-4, target_id: target_21.id, comment: "the score in championship league")
# progress_214 = Progress.create!(date: "2021-12-01", score: progress_114.score + rand(8)-4, target_id: target_21.id, comment: "the score in official game with Mike of ABC junior high school")
# progress_215 = Progress.create!(date: "2022-01-01", score: progress_115.score + rand(8)-4, target_id: target_21.id, comment: "the score in private game with John of the same junior high school")
# progress_216 = Progress.create!(date: "2022-02-01", score: progress_116.score + rand(8)-4, target_id: target_21.id, comment: "the score in championship league")
# progress_217 = Progress.create!(date: "2022-03-01", score: progress_117.score + rand(8)-4, target_id: target_21.id, comment: "the score in official game with Mike of ABC junior high school")
# progress_218 = Progress.create!(date: "2022-04-01", score: progress_118.score + rand(8)-4, target_id: target_21.id, comment: "the score in private game with John of the same junior high school")
# progress_219 = Progress.create!(date: "2022-05-01", score: progress_119.score + rand(8)-4, target_id: target_21.id, comment: "the score in championship league")

# progress_221 = Progress.create!(date: "2021-09-01", score: progress_121.score + rand(8)-4, target_id: target_22.id, comment: "the score in official game with Mike of ABC junior high school")
# progress_222 = Progress.create!(date: "2021-10-01", score: progress_122.score + rand(8)-4, target_id: target_22.id, comment: "the score in private game with John of the same junior high school")
# progress_223 = Progress.create!(date: "2021-11-01", score: progress_123.score + rand(8)-4, target_id: target_22.id, comment: "the score in championship league")
# progress_224 = Progress.create!(date: "2021-12-01", score: progress_124.score + rand(8)-4, target_id: target_22.id, comment: "the score in official game with Mike of ABC junior high school")
# progress_225 = Progress.create!(date: "2022-01-01", score: progress_125.score + rand(8)-4, target_id: target_22.id, comment: "the score in private game with John of the same junior high school")
# progress_226 = Progress.create!(date: "2022-02-01", score: progress_126.score + rand(8)-4, target_id: target_22.id, comment: "the score in championship league")
# progress_227 = Progress.create!(date: "2022-03-01", score: progress_127.score + rand(8)-4, target_id: target_22.id, comment: "the score in official game with Mike of ABC junior high school")
# progress_228 = Progress.create!(date: "2022-04-01", score: progress_128.score + rand(8)-4, target_id: target_22.id, comment: "the score in private game with John of the same junior high school")
# progress_229 = Progress.create!(date: "2022-05-01", score: progress_129.score + rand(8)-4, target_id: target_22.id, comment: "the score in championship league")

# Tennis Lesson (Intermediate) - shunjiros
progress_311 = Progress.create!(date: "2020-12-01", score: progress_111.score + 7 + rand(8)-4, target_id: target_31.id, comment: "the score in official game with Mike of ABC junior high school")
progress_312 = Progress.create!(date: "2021-01-01", score: progress_112.score + 7 + rand(8)-4, target_id: target_31.id, comment: "the score in private game with John of the same junior high school")
progress_313 = Progress.create!(date: "2021-02-01", score: progress_113.score + 7 + rand(8)-4, target_id: target_31.id, comment: "the score in championship league")
progress_314 = Progress.create!(date: "2021-03-01", score: progress_114.score + 7 + rand(8)-4, target_id: target_31.id, comment: "the score in official game with Mike of ABC junior high school")
progress_315 = Progress.create!(date: "2021-04-01", score: progress_115.score + 7 + rand(8)-4, target_id: target_31.id, comment: "the score in private game with John of the same junior high school")
progress_316 = Progress.create!(date: "2021-05-01", score: progress_116.score + 7 + rand(8)-4, target_id: target_31.id, comment: "the score in championship league")
progress_317 = Progress.create!(date: "2021-06-01", score: progress_117.score + 7 + rand(8)-4, target_id: target_31.id, comment: "the score in official game with Mike of ABC junior high school")
progress_318 = Progress.create!(date: "2021-07-01", score: progress_118.score + 7 + rand(8)-4, target_id: target_31.id, comment: "the score in private game with John of the same junior high school")
progress_319 = Progress.create!(date: "2021-08-01", score: progress_119.score + 7 + rand(8)-4, target_id: target_31.id, comment: "the score in championship league")
progress_3111 = Progress.create!(date: "2021-09-01", score: progress_1111.score + 7 + rand(8)-4, target_id: target_31.id, comment: "the score in official game with Mike of ABC junior high school")
progress_3112 = Progress.create!(date: "2021-10-01", score: progress_1112.score + 7 + rand(8)-4, target_id: target_31.id, comment: "the score in private game with John of the same junior high school")
progress_3113 = Progress.create!(date: "2021-11-01", score: progress_1113.score + 7.5 + rand(8)-4, target_id: target_31.id, comment: "the score in championship league")
progress_3114 = Progress.create!(date: "2021-12-01", score: progress_1114.score + 8 + rand(8)-4, target_id: target_31.id, comment: "the score in official game with Mike of ABC junior high school")
progress_3115 = Progress.create!(date: "2022-01-01", score: progress_1115.score + 8.5 + rand(8)-4, target_id: target_31.id, comment: "the score in private game with John of the same junior high school")
progress_3116 = Progress.create!(date: "2022-02-01", score: progress_1116.score + 9 + rand(8)-4, target_id: target_31.id, comment: "the score in championship league")
progress_3117 = Progress.create!(date: "2022-03-01", score: progress_1117.score + 9.5 + rand(8)-4, target_id: target_31.id, comment: "the score in official game with Mike of ABC junior high school")
progress_3118 = Progress.create!(date: "2022-04-01", score: progress_1118.score + 10 + rand(8)-4, target_id: target_31.id, comment: "the score in private game with John of the same junior high school")
progress_3119 = Progress.create!(date: "2022-05-01", score: progress_1119.score + 10.5 + rand(8)-4, target_id: target_31.id, comment: "the score in championship league")

progress_321 = Progress.create!(date: "2020-12-01", score: progress_121.score + rand(8)-4, target_id: target_32.id, comment: "the score in official game with Mike of ABC junior high school")
progress_322 = Progress.create!(date: "2021-01-01", score: progress_122.score + rand(8)-4, target_id: target_32.id, comment: "the score in private game with John of the same junior high school")
progress_323 = Progress.create!(date: "2021-02-01", score: progress_123.score + rand(8)-4, target_id: target_32.id, comment: "the score in championship league")
progress_324 = Progress.create!(date: "2021-03-01", score: progress_124.score + rand(8)-4, target_id: target_32.id, comment: "the score in official game with Mike of ABC junior high school")
progress_325 = Progress.create!(date: "2021-04-01", score: progress_125.score + rand(8)-4, target_id: target_32.id, comment: "the score in private game with John of the same junior high school")
progress_326 = Progress.create!(date: "2021-05-01", score: progress_126.score + rand(8)-4, target_id: target_32.id, comment: "the score in championship league")
progress_327 = Progress.create!(date: "2021-06-01", score: progress_127.score + rand(8)-4, target_id: target_32.id, comment: "the score in official game with Mike of ABC junior high school")
progress_328 = Progress.create!(date: "2021-07-01", score: progress_128.score + rand(8)-4, target_id: target_32.id, comment: "the score in private game with John of the same junior high school")
progress_329 = Progress.create!(date: "2021-08-01", score: progress_129.score + rand(8)-4, target_id: target_32.id, comment: "the score in championship league")
progress_3211 = Progress.create!(date: "2021-09-01", score: progress_121.score + rand(8)-4, target_id: target_32.id, comment: "the score in official game with Mike of ABC junior high school")
progress_3212 = Progress.create!(date: "2021-10-01", score: progress_122.score + rand(8)-4, target_id: target_32.id, comment: "the score in private game with John of the same junior high school")
progress_3213 = Progress.create!(date: "2021-11-01", score: progress_123.score + rand(8)-4, target_id: target_32.id, comment: "the score in championship league")
progress_3214 = Progress.create!(date: "2021-12-01", score: progress_124.score + rand(8)-4, target_id: target_32.id, comment: "the score in official game with Mike of ABC junior high school")
progress_3215 = Progress.create!(date: "2022-01-01", score: progress_125.score + rand(8)-4, target_id: target_32.id, comment: "the score in private game with John of the same junior high school")
progress_3216 = Progress.create!(date: "2022-02-01", score: progress_126.score + rand(8)-4, target_id: target_32.id, comment: "the score in championship league")
progress_3217 = Progress.create!(date: "2022-03-01", score: progress_127.score + rand(8)-4, target_id: target_32.id, comment: "the score in official game with Mike of ABC junior high school")
progress_3218 = Progress.create!(date: "2022-04-01", score: progress_128.score + rand(8)-4, target_id: target_32.id, comment: "the score in private game with John of the same junior high school")
progress_3219 = Progress.create!(date: "2022-05-01", score: progress_129.score + rand(8)-4, target_id: target_32.id, comment: "the score in championship league")

# Tennis Lesson (Beginner) - shingos
progress_1111 = Progress.create!(date: "2020-04-01", score: progress_311.score + rand(8)-4, target_id: target_111.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1112 = Progress.create!(date: "2020-05-01", score: progress_312.score + rand(8)-4, target_id: target_111.id, comment: "the score in private game with John of the same junior high school")
progress_1113 = Progress.create!(date: "2020-06-01", score: progress_313.score + rand(8)-4, target_id: target_111.id, comment: "the score in championship league")
progress_1114 = Progress.create!(date: "2020-07-01", score: progress_314.score + rand(8)-4, target_id: target_111.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1115 = Progress.create!(date: "2020-08-01", score: progress_315.score + rand(8)-4, target_id: target_111.id, comment: "the score in private game with John of the same junior high school")
progress_1116 = Progress.create!(date: "2020-09-01", score: progress_316.score + rand(8)-4, target_id: target_111.id, comment: "the score in championship league")
progress_1117 = Progress.create!(date: "2020-10-01", score: progress_317.score + rand(8)-4, target_id: target_111.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1118 = Progress.create!(date: "2020-11-01", score: progress_318.score + rand(8)-4, target_id: target_111.id, comment: "the score in private game with John of the same junior high school")
progress_1119 = Progress.create!(date: "2020-12-01", score: progress_319.score + rand(8)-4, target_id: target_111.id, comment: "the score in championship league")

progress_1121 = Progress.create!(date: "2020-04-01", score: progress_321.score + rand(8)-4, target_id: target_112.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1122 = Progress.create!(date: "2020-05-01", score: progress_322.score + rand(8)-4, target_id: target_112.id, comment: "the score in private game with John of the same junior high school")
progress_1123 = Progress.create!(date: "2020-06-01", score: progress_323.score + rand(8)-4, target_id: target_112.id, comment: "the score in championship league")
progress_1124 = Progress.create!(date: "2020-07-01", score: progress_324.score + rand(8)-4, target_id: target_112.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1125 = Progress.create!(date: "2020-08-01", score: progress_325.score + rand(8)-4, target_id: target_112.id, comment: "the score in private game with John of the same junior high school")
progress_1126 = Progress.create!(date: "2020-09-01", score: progress_326.score + rand(8)-4, target_id: target_112.id, comment: "the score in championship league")
progress_1127 = Progress.create!(date: "2020-10-01", score: progress_327.score + rand(8)-4, target_id: target_112.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1128 = Progress.create!(date: "2020-11-01", score: progress_328.score + rand(8)-4, target_id: target_112.id, comment: "the score in private game with John of the same junior high school")
progress_1129 = Progress.create!(date: "2020-12-01", score: progress_329.score + rand(8)-4, target_id: target_112.id, comment: "the score in championship league")

# Tennis Lesson (Advanced) - James
progress_2111 = Progress.create!(date: "2021-09-01", score: progress_311.score + rand(8)-4, target_id: target_211.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2112 = Progress.create!(date: "2021-10-01", score: progress_312.score + rand(8)-4, target_id: target_211.id, comment: "the score in private game with John of the same junior high school")
progress_2113 = Progress.create!(date: "2021-11-01", score: progress_313.score + rand(8)-4, target_id: target_211.id, comment: "the score in championship league")
progress_2114 = Progress.create!(date: "2021-12-01", score: progress_314.score + rand(8)-4, target_id: target_211.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2115 = Progress.create!(date: "2022-01-01", score: progress_315.score + rand(8)-4, target_id: target_211.id, comment: "the score in private game with John of the same junior high school")
progress_2116 = Progress.create!(date: "2022-02-01", score: progress_316.score + rand(8)-4, target_id: target_211.id, comment: "the score in championship league")
progress_2117 = Progress.create!(date: "2022-03-01", score: progress_317.score + rand(8)-4, target_id: target_211.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2118 = Progress.create!(date: "2022-04-01", score: progress_318.score + rand(8)-4, target_id: target_211.id, comment: "the score in private game with John of the same junior high school")
progress_2119 = Progress.create!(date: "2022-05-01", score: progress_319.score + rand(8)-4, target_id: target_211.id, comment: "the score in championship league")

# English Lesson
progress_3111 = Progress.create!(date: "2021-09-01", score: 20, target_id: target_311.id, comment: "official TOEFL exam")
progress_3112 = Progress.create!(date: "2021-10-01", score: 21, target_id: target_311.id, comment: "official TOEFL exam")
progress_3113 = Progress.create!(date: "2021-11-01", score: 22, target_id: target_311.id, comment: "mock TOEFL exam")
progress_3114 = Progress.create!(date: "2021-12-01", score: 23, target_id: target_311.id, comment: "official TOEFL exam")
progress_3115 = Progress.create!(date: "2022-01-01", score: 25, target_id: target_311.id, comment: "official TOEFL exam")
progress_3116 = Progress.create!(date: "2022-02-01", score: 24, target_id: target_311.id, comment: "mock TOEFL exam")
progress_3117 = Progress.create!(date: "2022-03-01", score: 25, target_id: target_311.id, comment: "official TOEFL exam")
progress_3118 = Progress.create!(date: "2022-04-01", score: 26, target_id: target_311.id, comment: "official TOEFL exam")
progress_3119 = Progress.create!(date: "2022-05-01", score: 27, target_id: target_311.id, comment: "mock TOEFL exam")

progress_3121 = Progress.create!(date: "2021-09-01", score: 18, target_id: target_312.id, comment: "official TOEFL exam")
progress_3122 = Progress.create!(date: "2021-10-01", score: 17, target_id: target_312.id, comment: "official TOEFL exam")
progress_3123 = Progress.create!(date: "2021-11-01", score: 21, target_id: target_312.id, comment: "mock TOEFL exam")
progress_3124 = Progress.create!(date: "2021-12-01", score: 18, target_id: target_312.id, comment: "official TOEFL exam")
progress_3125 = Progress.create!(date: "2022-01-01", score: 17, target_id: target_312.id, comment: "official TOEFL exam")
progress_3126 = Progress.create!(date: "2022-02-01", score: 21, target_id: target_312.id, comment: "mock TOEFL exam")
progress_3127 = Progress.create!(date: "2022-03-01", score: 18, target_id: target_312.id, comment: "official TOEFL exam")
progress_3128 = Progress.create!(date: "2022-04-01", score: 17, target_id: target_312.id, comment: "official TOEFL exam")
progress_3129 = Progress.create!(date: "2022-05-01", score: 21, target_id: target_312.id, comment: "mock TOEFL exam")

progress_3131 = Progress.create!(date: "2021-09-01", score: 16, target_id: target_313.id, comment: "official TOEFL exam")
progress_3132 = Progress.create!(date: "2021-10-01", score: 15, target_id: target_313.id, comment: "official TOEFL exam")
progress_3133 = Progress.create!(date: "2021-11-01", score: 18, target_id: target_313.id, comment: "mock TOEFL exam")
progress_3134 = Progress.create!(date: "2021-12-01", score: 16, target_id: target_313.id, comment: "official TOEFL exam")
progress_3135 = Progress.create!(date: "2022-01-01", score: 15, target_id: target_313.id, comment: "official TOEFL exam")
progress_3136 = Progress.create!(date: "2022-02-01", score: 16, target_id: target_313.id, comment: "mock TOEFL exam")
progress_3137 = Progress.create!(date: "2022-03-01", score: 17, target_id: target_313.id, comment: "official TOEFL exam")
progress_3138 = Progress.create!(date: "2022-04-01", score: 15, target_id: target_313.id, comment: "official TOEFL exam")
progress_3139 = Progress.create!(date: "2022-05-01", score: 18, target_id: target_313.id, comment: "mock TOEFL exam")

progress_3141 = Progress.create!(date: "2021-09-01", score: 23, target_id: target_314.id, comment: "official TOEFL exam")
progress_3142 = Progress.create!(date: "2021-10-01", score: 25, target_id: target_314.id, comment: "official TOEFL exam")
progress_3143 = Progress.create!(date: "2021-11-01", score: 24, target_id: target_314.id, comment: "mock TOEFL exam")
progress_3144 = Progress.create!(date: "2021-12-01", score: 26, target_id: target_314.id, comment: "official TOEFL exam")
progress_3145 = Progress.create!(date: "2022-01-01", score: 25, target_id: target_314.id, comment: "official TOEFL exam")
progress_3146 = Progress.create!(date: "2022-02-01", score: 26, target_id: target_314.id, comment: "mock TOEFL exam")
progress_3147 = Progress.create!(date: "2022-03-01", score: 26, target_id: target_314.id, comment: "official TOEFL exam")
progress_3148 = Progress.create!(date: "2022-04-01", score: 27, target_id: target_314.id, comment: "official TOEFL exam")
progress_3149 = Progress.create!(date: "2022-05-01", score: 28, target_id: target_314.id, comment: "mock TOEFL exam")

puts "Generated #{Progress.all.count} Progresses successfully"

puts "Remember :#{Faker::Marketing.buzzwords}"
