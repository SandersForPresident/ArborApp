FactoryGirl.define do
  factory :team do
    sequence :name do |n|
      "Team #{n}"
    end
  end
end
