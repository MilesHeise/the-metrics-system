FactoryBot.define do
  factory :event do
    name Faker::Hacker.verb
    association :registered_application
  end
end
