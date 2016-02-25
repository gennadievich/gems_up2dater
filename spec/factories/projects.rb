FactoryGirl.define do
  factory :project do
    name        { Faker::Name.name }
    description { Faker::Lorem.sentence }
    link        { Faker::Internet.url }
    user_id 1
  end
end
