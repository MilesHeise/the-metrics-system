FactoryBot.define do
  factory :registered_application do
    name Faker::Company.unique.bs
    url Faker::Internet.unique.url
    association :user
  end
end
