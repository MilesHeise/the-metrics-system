FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password Faker::Internet.password
    username Faker::VentureBros.unique.character
  end
end
