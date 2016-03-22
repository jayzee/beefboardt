FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    password "password"
    sequence(:email) { |n| "example-#{n}@example.com" }
  end

  factory :event do
    name "Event"
    location "A Great Location"
    event_time { DateTime.current + 1.week }
    signup_deadline { DateTime.current + 1.day }
    minimum_attendees 4

    trait :confirmed do
      confirmed true
    end
  end 

  factory :attendee do
    user
    event
  end
end