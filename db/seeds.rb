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


puts 'Cleaning up assignments...'
Assignment.destroy_all
puts 'Cleaning up courses...'
Course.destroy_all
puts 'Cleaning up users...'
User.destroy_all

puts '===================================='

puts "Generating personal tutor seeds"
User.create(email: 'shingo@mail.com', first_name: 'Shingo', last_name: 'Kubomura', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
User.create(email: 'ed@mail.com', first_name: 'Ed', last_name: 'Oz', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
User.create(email: 'shunjiro@mail.com', first_name: 'Shunjiro', last_name: 'Yatsuzuka', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
User.create(email: 'tutor@mail.com',nickname:"1234", first_name: 'Teachy', last_name: 'McTeacherson', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")

puts "Generating random tutor seeds..."

5.times do
  User.create(email: "#{Faker::Internet.email}", first_name: "#{Faker::Name.name.split[0]}", last_name: "#{Faker::Name.name.split[1]}", password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
end

puts "Generated #{user_count("tutor")} #{Faker::Emotion.adjective} new tutors"
puts '===================================='
puts "#{Faker::Hacker.ingverb} personal student seeds..."

User.create(email: 'shingos@mail.com', first_name: 'Shingo', last_name: 'Kubomura', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")
User.create(email: 'eds@mail.com', first_name: 'Ed', last_name: 'Oz', password: '11221122', role: 'student')
User.create(email: 'shunjiros@mail.com', first_name: 'Shunjiro', last_name: 'Yatsuzuka', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")
User.create(email: 'tutors@mail.com',nickname: "1234", first_name: 'Teachy', last_name: 'McTeacherson', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")

puts "Generating random student seeds..."

15.times do
User.create(email: "#{Faker::Internet.email}", first_name: "#{Faker::Name.name.split[0]}", last_name: "#{Faker::Name.name.split[1]}", password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")
end

puts "Generated #{user_count("student")} #{Faker::Emotion.adjective} new students"
puts '===================================='


puts '===================================='

puts "Generating courses..."
20.times do
Course.create(name: "#{Faker::JapaneseMedia::Doraemon.gadget}-101", description: "#{Faker::Movies::Lebowski.quote}", tutor_user_id: User.where(role:"tutor").sample.id, student_user_id: User.where(role: "student").sample.id )
end

puts "Generated #{Course.all.count} courses successfully"

puts '===================================='


puts 'Generating assignments...'
30.times do
title= "#{Faker::Verb.ing_form.capitalize} practice"
checkpoint= "can #{Faker::Verb.base} #{rand(100)} times in a row"
instruction = "#{Faker::Quote.yoda}"
comment = "#{Faker::Quote.robin}"
status = rand(3)

Assignment.create(title: title, instruction: instruction, comment: comment, checkpoint: checkpoint, course_id: Course.all.sample.id, status: status)

end
puts "Generated #{Assignment.all.count} Assignments successfully"


puts "Remember :#{Faker::Marketing.buzzwords}"
