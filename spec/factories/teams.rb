FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| "Team #{n}" }
    sequence(:slack_team_id) { |n| "#{n}" }
    sequence(:slack_team_domain) { |n| "myteam#{n}" }
  end
end
