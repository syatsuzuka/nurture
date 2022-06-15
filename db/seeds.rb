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
puts "Generating sample users seeds..."

sample_tutor = User.create!(email: ENV['SAMPLE_TUTOR_LOGIN_ID'], nickname: "Sample Tutor", first_name: 'Sample', last_name: 'Tutor', password: ENV['SAMPLE_TUTOR_LOGIN_PASSWORD'], role: 'tutor', message: "Welcome to Nurture! Please feel free to ask any questions about our Nurture platform.", specialty: "To help users for better learning experiences", avatar_url: "#{Faker::LoremPixel.image}")
sample_student = User.create!(email: ENV['SAMPLE_STUDENT_LOGIN_ID'], nickname: "Sample Student", first_name: 'Sample', last_name: 'Student', password: ENV['SAMPLE_STUDENT_LOGIN_PASSWORD'], role: 'student', message: "Welcome to Nurture! Please feel free to ask any questions about our Nurture platform.", interest: "To help users for better learning experiences", avatar_url: "#{Faker::LoremPixel.image}")

demo_tutor = User.create!(email: ENV['DEMO_TUTOR_LOGIN_ID'], nickname: "ed", first_name: 'Ed', last_name: 'Oz', password: ENV['DEMO_TUTOR_LOGIN_PASSWORD'], role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
demo_student = User.create!(email: ENV['DEMO_STUDENT_LOGIN_ID'], nickname: "shingo", first_name: 'Shingo', last_name: 'Kubomura', password: ENV['DEMO_STUDENT_LOGIN_PASSWORD'], role: 'student', avatar_url: "#{Faker::LoremPixel.image}")

puts "Generated #{user_count("tutor")} #{Faker::Emotion.adjective} new tutors"
puts "Generated #{user_count("student")} #{Faker::Emotion.adjective} new students"
puts '===================================='

puts '===================================='
puts "Generating courses..."
course_1 = Course.create!(name: "Tennis Lesson (Beginner)", description: "Private Tennis Lesson for complete beginners.", status: 1, tutor: demo_tutor, student: demo_student )
chatroom_1 = Chatroom.create!(name: "Assignment chat")

course_2 = Course.create!(name: "Tennis Lesson (Intermediate)", description: "Private Tennis Lesson to help to win the junior high school student's championship.", status: 1, tutor: demo_tutor, student: demo_student )
chatroom_2 = Chatroom.create!(name: "Assignment chat")

puts "Generated #{Course.all.count} courses successfully"

puts '===================================='
puts 'Generating assignments...'

assignment_11 = Assignment.create!(title: "Swing Practice every day", instruction: "Take 30mins for shadow swing everyday", comment: "", checkpoint: "Take 60mins every days", course_id: course_1.id, status: 2, start_date: "2020-09-01", end_date: "2020-12-31")
assignment_21 = Assignment.create!(title: "Smash Practice", instruction: "Practice Smash with machine", comment: "", checkpoint: "Have 5 sets of 10 times every two days", course_id: course_2.id, status: 2, start_date: "2022-01-01", end_date: "2022-03-31")

puts "Generated #{Assignment.all.count} Assignments successfully"

puts '===================================='
puts 'Generating targets...'
target_11 = Target.create!(name: "Forhand Stroke (%)", fullpath: "/ Forhand Stroke (%)", description: "Achieve higher successful rate in Forehand Stroke.", score: 40, display: true, course_id: course_1.id, parent_id: nil )
target_12 = Target.create!(name: "Backhand Stroke (%)", fullpath: "/ Backhand Stroke (%)", description: "Achieve higher successful rate in Backhand Stroke.", score: 20, display: true, course_id: course_1.id, parent_id: nil )

target_21 = Target.create!(name: "Service Ace Rate (%)", fullpath: "/ Service Ace Rate (%)", description: "Achieve higher successful rate in Serviece Ace.", score: 30, display: true, course_id: course_2.id, parent_id: nil )
target_22 = Target.create!(name: "Return Ace Rate (%)", fullpath: "/ Return Ace Rate (%)", description: "Achieve higher successful rate in Return Ace.", score: 10, display: true, course_id: course_2.id, parent_id: nil )

puts "Generated #{Target.all.count} Targets successfully"

puts '===================================='
puts 'Generating progresses...'

# Tennis Lesson (Beginner) - tutor_1 / student_1
progress_1101 = Progress.create!(date: "2020-04-01", score: target_11.score - 2.0 + rand(8)-4, target_id: target_11.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1102 = Progress.create!(date: "2020-05-01", score: target_11.score - 1.5 + rand(8)-4, target_id: target_11.id, comment: "the score in private game with John of the same junior high school")
progress_1103 = Progress.create!(date: "2020-06-01", score: target_11.score - 1.0 + rand(8)-4, target_id: target_11.id, comment: "the score in championship league")
progress_1104 = Progress.create!(date: "2020-07-01", score: target_11.score - 0.5 + rand(8)-4, target_id: target_11.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1105 = Progress.create!(date: "2020-08-01", score: target_11.score + 0.0 + rand(8)-4, target_id: target_11.id, comment: "the score in private game with John of the same junior high school")
progress_1106 = Progress.create!(date: "2020-09-01", score: target_11.score + 0.5 + rand(8)-4, target_id: target_11.id, comment: "the score in championship league")
progress_1107 = Progress.create!(date: "2020-10-01", score: target_11.score + 1.0 + rand(8)-4, target_id: target_11.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1108 = Progress.create!(date: "2020-11-01", score: target_11.score + 1.5 + rand(8)-4, target_id: target_11.id, comment: "the score in private game with John of the same junior high school")
progress_1109 = Progress.create!(date: "2020-12-01", score: target_11.score + 2.0 + rand(8)-4, target_id: target_11.id, comment: "the score in championship league")

progress_1201 = Progress.create!(date: "2020-04-01", score: target_12.score - 2.0 + rand(8)-4, target_id: target_12.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1202 = Progress.create!(date: "2020-05-01", score: target_12.score - 1.5 + rand(8)-4, target_id: target_12.id, comment: "the score in private game with John of the same junior high school")
progress_1203 = Progress.create!(date: "2020-06-01", score: target_12.score - 1.0 + rand(8)-4, target_id: target_12.id, comment: "the score in championship league")
progress_1204 = Progress.create!(date: "2020-07-01", score: target_12.score - 0.5 + rand(8)-4, target_id: target_12.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1205 = Progress.create!(date: "2020-08-01", score: target_12.score + 0.0 + rand(8)-4, target_id: target_12.id, comment: "the score in private game with John of the same junior high school")
progress_1206 = Progress.create!(date: "2020-09-01", score: target_12.score + 0.5 + rand(8)-4, target_id: target_12.id, comment: "the score in championship league")
progress_1207 = Progress.create!(date: "2020-10-01", score: target_12.score + 1.0 + rand(8)-4, target_id: target_12.id, comment: "the score in official game with Mike of ABC junior high school")
progress_1208 = Progress.create!(date: "2020-11-01", score: target_12.score + 1.5 + rand(8)-4, target_id: target_12.id, comment: "the score in private game with John of the same junior high school")
progress_1209 = Progress.create!(date: "2020-12-01", score: target_12.score + 2.0 + rand(8)-4, target_id: target_12.id, comment: "the score in championship league")

# Tennis Lesson (Intermediate) - tutor_1 / student_1
progress_2101 = Progress.create!(date: "2020-12-01", score: target_21.score - 5.5 + rand(8)-4, target_id: target_21.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2102 = Progress.create!(date: "2021-01-01", score: target_21.score - 5.0 + rand(8)-4, target_id: target_21.id, comment: "the score in private game with John of the same junior high school")
progress_2103 = Progress.create!(date: "2021-02-01", score: target_21.score - 4.5 + rand(8)-4, target_id: target_21.id, comment: "the score in championship league")
progress_2104 = Progress.create!(date: "2021-03-01", score: target_21.score - 4.0 + rand(8)-4, target_id: target_21.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2105 = Progress.create!(date: "2021-04-01", score: target_21.score - 3.5 + rand(8)-4, target_id: target_21.id, comment: "the score in private game with John of the same junior high school")
progress_2106 = Progress.create!(date: "2021-05-01", score: target_21.score - 3.0 + rand(8)-4, target_id: target_21.id, comment: "the score in championship league")
progress_2107 = Progress.create!(date: "2021-06-01", score: target_21.score - 2.5 + rand(8)-4, target_id: target_21.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2108 = Progress.create!(date: "2021-07-01", score: target_21.score - 2.0 + rand(8)-4, target_id: target_21.id, comment: "the score in private game with John of the same junior high school")
progress_2109 = Progress.create!(date: "2021-08-01", score: target_21.score - 2.0 + rand(8)-4, target_id: target_21.id, comment: "the score in championship league")
progress_2110 = Progress.create!(date: "2021-09-01", score: target_21.score - 2.0 + rand(8)-4, target_id: target_21.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2111 = Progress.create!(date: "2021-10-01", score: target_21.score - 2.0 + rand(8)-4, target_id: target_21.id, comment: "the score in private game with John of the same junior high school")
progress_2112 = Progress.create!(date: "2021-11-01", score: target_21.score - 2.0 + rand(8)-4, target_id: target_21.id, comment: "the score in championship league")
progress_2113 = Progress.create!(date: "2021-12-01", score: target_21.score - 2.0 + rand(8)-4, target_id: target_21.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2114 = Progress.create!(date: "2022-01-01", score: target_21.score - 2.0 + rand(8)-4, target_id: target_21.id, comment: "the score in private game with John of the same junior high school")
progress_2115 = Progress.create!(date: "2022-02-01", score: target_21.score - 2.0 + rand(8)-4, target_id: target_21.id, comment: "the score in championship league")
progress_2116 = Progress.create!(date: "2022-03-01", score: target_21.score - 2.0 + rand(8)-4, target_id: target_21.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2117 = Progress.create!(date: "2022-04-01", score: target_21.score - 2.0 + rand(8)-4, target_id: target_21.id, comment: "the score in private game with John of the same junior high school")
progress_2118 = Progress.create!(date: "2022-05-01", score: target_21.score - 2.0 + rand(8)-4, target_id: target_21.id, comment: "the score in championship league")

progress_2201 = Progress.create!(date: "2020-12-01", score: target_22.score - 5.5 + rand(8)-4, target_id: target_22.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2202 = Progress.create!(date: "2021-01-01", score: target_22.score - 5.0 + rand(8)-4, target_id: target_22.id, comment: "the score in private game with John of the same junior high school")
progress_2203 = Progress.create!(date: "2021-02-01", score: target_22.score - 4.5 + rand(8)-4, target_id: target_22.id, comment: "the score in championship league")
progress_2204 = Progress.create!(date: "2021-03-01", score: target_22.score - 4.0 + rand(8)-4, target_id: target_22.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2205 = Progress.create!(date: "2021-04-01", score: target_22.score - 4.5 + rand(8)-4, target_id: target_22.id, comment: "the score in private game with John of the same junior high school")
progress_2206 = Progress.create!(date: "2021-05-01", score: target_22.score - 4.0 + rand(8)-4, target_id: target_22.id, comment: "the score in championship league")
progress_2207 = Progress.create!(date: "2021-06-01", score: target_22.score - 3.5 + rand(8)-4, target_id: target_22.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2208 = Progress.create!(date: "2021-07-01", score: target_22.score - 3.0 + rand(8)-4, target_id: target_22.id, comment: "the score in private game with John of the same junior high school")
progress_2209 = Progress.create!(date: "2021-08-01", score: target_22.score - 2.5 + rand(8)-4, target_id: target_22.id, comment: "the score in championship league")
progress_2210 = Progress.create!(date: "2021-09-01", score: target_22.score - 2.0 + rand(8)-4, target_id: target_22.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2211 = Progress.create!(date: "2021-10-01", score: target_22.score - 1.5 + rand(8)-4, target_id: target_22.id, comment: "the score in private game with John of the same junior high school")
progress_2212 = Progress.create!(date: "2021-11-01", score: target_22.score - 1.0 + rand(8)-4, target_id: target_22.id, comment: "the score in championship league")
progress_2213 = Progress.create!(date: "2021-12-01", score: target_22.score - 0.5 + rand(8)-4, target_id: target_22.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2214 = Progress.create!(date: "2022-01-01", score: target_22.score + 0.0 + rand(8)-4, target_id: target_22.id, comment: "the score in private game with John of the same junior high school")
progress_2215 = Progress.create!(date: "2022-02-01", score: target_22.score + 0.5 + rand(8)-4, target_id: target_22.id, comment: "the score in championship league")
progress_2216 = Progress.create!(date: "2022-03-01", score: target_22.score + 1.0 + rand(8)-4, target_id: target_22.id, comment: "the score in official game with Mike of ABC junior high school")
progress_2217 = Progress.create!(date: "2022-04-01", score: target_22.score + 1.5 + rand(8)-4, target_id: target_22.id, comment: "the score in private game with John of the same junior high school")
progress_2218 = Progress.create!(date: "2022-05-01", score: target_22.score + 2.0 + rand(8)-4, target_id: target_22.id, comment: "the score in championship league")

puts "Generated #{Progress.all.count} Progresses successfully"

puts "Remember :#{Faker::Marketing.buzzwords}"
