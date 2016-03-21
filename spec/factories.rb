FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    password "password"
    sequence(:email) { |n| "example-#{n}@example.com" }
  end
end