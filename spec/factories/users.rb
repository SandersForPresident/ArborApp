FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "dough-#{n}@example.com" }
    provider 'slack'
    slack_access_token 'A_TOKEN'
    name 'Some name'
    avatar 'some_url_of_an_avatar.jpg'
    sequence(:uid) { |n| n }
  end
end
