FactoryGirl.define do
  factory :membership do
    user

    factory :group_member_membership do
      association :joinable, factory: :group

      factory :group_admin_membership do
        role :admin
      end
    end

    factory :team_member_membership do
      association :joinable, factory: :team

      factory :team_admin_membership do
        role :admin
      end
    end
  end
end
