# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Cleaning up users'
puts '===================================='
User.delete_all
puts 'Generating personal tutor seeds'
User.create(email: 'shingo@mail.com', first_name: 'Shingo', last_name: 'Kubomura', password: '11221122', role: 'tutor')
User.create(email: 'ed@mail.com', first_name: 'Ed', last_name: 'Oz', password: '11221122', role: 'tutor')
User.create(email: 'shunjiro@mail.com', first_name: 'Shunjiro', last_name: 'Yatsuzuka', password: '11221122', role: 'tutor')
User.create(email: 'tutor@mail.com', first_name: 'Teachy', last_name: 'McTeacherson', password: '11221122', role: 'tutor')

puts 'Generating random tutor seeds'

5.times do
  User.create(email: "#{Faker::Internet.email}", first_name: "#{Faker::Name.name.split[0]}", last_name: "#{Faker::Name.name.split[1]}", password: '11221122', role: 'tutor')
end

puts "#{User.where(role: "tutor").count} new tutors standing in a row"
puts '===================================='
puts 'Generating personal student seeds'

User.create(email: 'shingo@mail.com', first_name: 'Shingo', last_name: 'Kubomura', password: '11221122', role: 'student')
User.create(email: 'ed@mail.com', first_name: 'Ed', last_name: 'Oz', password: '11221122', role: 'student')
User.create(email: 'shunjiro@mail.com', first_name: 'Shunjiro', last_name: 'Yatsuzuka', password: '11221122', role: 'student')
User.create(email: 'tutor@mail.com', first_name: 'Teachy', last_name: 'McTeacherson', password: '11221122', role: 'student')

puts 'Generating random student seeds'

15.times do
User.create(email: "#{Faker::Internet.email}", first_name: "#{Faker::Name.name.split[0]}", last_name: "#{Faker::Name.name.split[1]}", password: '11221122', role: 'student')
end

puts "Generated #{User.where(role: "student").count} shiny new students"
puts '===================================='
