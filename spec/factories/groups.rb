# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    sequence :name do |n|
      "Group #{n}"
    end
  end
end
