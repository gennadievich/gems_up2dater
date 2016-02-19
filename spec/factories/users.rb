FactoryGirl.define do
  factory :user do
    name      {Faker::Name.name}
    email     {Faker::Internet.email}
    password  "password"

    factory :admin do
      role_id 2
    end
  end
end
