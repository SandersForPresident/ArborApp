# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill do
    sequence :name do |n|
      "Skill #{n}"
    end
  end
end
