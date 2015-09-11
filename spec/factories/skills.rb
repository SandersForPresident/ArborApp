FactoryGirl.define do
  factory :skill do
    sequence :name do |n|
      "Skill #{n}"
    end
  end
end
