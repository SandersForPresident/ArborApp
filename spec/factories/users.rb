FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    sequence(:name) { |n| "User #{n} Name" }
    sequence(:avatar) { |n| "user_#{n}_avatar.jpg" }
  end
end
