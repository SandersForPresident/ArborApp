FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    provider 'slack'
    sequence(:slack_access_token) { |n| "SLACK_ACCESS_TOKEN_#{n}" }
    sequence(:name) { |n| "User #{n} Name" }
    sequence(:avatar) { |n| "user_#{n}_avatar.jpg" }
    sequence(:uid) { |n| n }
  end
end
