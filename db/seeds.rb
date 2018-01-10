require 'faker'

# Create Users
5.times do
  User.create!(
    username: Faker::VentureBros.unique.character,
    email:    Faker::Internet.unique.email,
    password: Faker::Internet.password
  )
end
users = User.all

# Creat Registered Applications
15.times do
  RegisteredApplication.create!(
    name:  Faker::Company.unique.bs,
    url:   Faker::Internet.unique.url,
    user: users.sample
  )
end
registered_applications = RegisteredApplication.all

# Create a test user with apps
member = User.create!(
  username: 'SampleGuy',
  email:    'member@example.com',
  password: 'helloworld'
)

5.times do
  RegisteredApplication.create!(
    name:  Faker::Company.unique.bs,
    url:   Faker::Internet.unique.url,
    user: member
  )
end

puts 'Seed finished'
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} registered apps created"
