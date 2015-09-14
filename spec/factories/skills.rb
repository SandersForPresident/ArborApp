FactoryGirl.define do
  factory :skill do
    sequence(:name) { |n| "Skill #{n}" }
  end
end
