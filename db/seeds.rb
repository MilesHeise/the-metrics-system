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

# Create Registered Applications
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
    user: member,
    created_at: rand(10.years).seconds.ago
  )
end

test_app = RegisteredApplication.create!(
  name: 'YourTestApp',
  url: 'http://localhost:4000',
  user: member
)

# Create events
100.times do
  Event.create!(
    registered_application: registered_applications.where.not(id: 21).sample,
    name: Faker::Hacker.verb
  )
end

500.times do
  Event.create!(
    registered_application: registered_applications.where(id: [16, 17, 18, 19, 20]).sample,
    name: Faker::Hacker.verb,
    created_at: rand(1.years).seconds.ago
  )
end
events = Event.all

puts 'Seed finished'
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} registered apps created"
puts "#{Event.count} events created"
