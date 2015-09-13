FactoryGirl.define do
  factory :group do
    sequence :name do |n|
      "Group #{n}"
    end

    team

    factory :group_with_parent do
      parent_group factory: :group
    end

    factory :group_with_grandparent do
      parent_group factory: :group_with_parent
    end
  end
end
