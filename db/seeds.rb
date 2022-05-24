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

puts 'Cleaning up users...'
puts '===================================='
User.delete_all
puts "Generating personal tutor seeds"
User.create(email: 'shingo@mail.com', first_name: 'Shingo', last_name: 'Kubomura', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
User.create(email: 'ed@mail.com', first_name: 'Ed', last_name: 'Oz', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
User.create(email: 'shunjiro@mail.com', first_name: 'Shunjiro', last_name: 'Yatsuzuka', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
User.create(email: 'tutor@mail.com', first_name: 'Teachy', last_name: 'McTeacherson', password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")

puts "Generating random tutor seeds..."

5.times do
  User.create(email: "#{Faker::Internet.email}", first_name: "#{Faker::Name.name.split[0]}", last_name: "#{Faker::Name.name.split[1]}", password: '11221122', role: 'tutor', avatar_url: "#{Faker::LoremPixel.image}")
end

puts "#{user_count("tutor")} new tutors standing in a row"
puts '===================================='
puts "#{Faker::Hacker.ingverb} personal student seeds..."

User.create(email: 'shingo@mail.com', first_name: 'Shingo', last_name: 'Kubomura', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")
User.create(email: 'ed@mail.com', first_name: 'Ed', last_name: 'Oz', password: '11221122', role: 'student')
User.create(email: 'shunjiro@mail.com', first_name: 'Shunjiro', last_name: 'Yatsuzuka', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")
User.create(email: 'tutor@mail.com', first_name: 'Teachy', last_name: 'McTeacherson', password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")

puts "Generating random student seeds..."

15.times do
User.create(email: "#{Faker::Internet.email}", first_name: "#{Faker::Name.name.split[0]}", last_name: "#{Faker::Name.name.split[1]}", password: '11221122', role: 'student', avatar_url: "#{Faker::LoremPixel.image}")
end

puts "Generated #{user_count("student")} shiny new students"
puts '===================================='

puts 'Cleaning up courses...'
Course.delete_all
puts '===================================='

puts "Generating courses..."
20.times do
Course.create(name: "#{Faker::JapaneseMedia::Doraemon.gadget}-101", description: "#{Faker::Movies::Lebowski.quote}", tutor_user_id: User.where(role:"tutor").sample.id, student_user_id: User.where(role: "student").sample.id )
end

puts "Generated #{Course.all.count} courses successfully"

puts '===================================='
puts "#{Faker::Marketing.buzzwords}"
