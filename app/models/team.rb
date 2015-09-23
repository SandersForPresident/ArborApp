class Team < ActiveRecord::Base
  include Joinable

  validates :slack_team_id, presence: true, uniqueness: true

  def self.find_or_create_with_auth_hash(auth_team_hash)
    find_or_initialize_by(
      slack_team_id: auth_team_hash['slack_team_id']
    ).tap do |team|
      team.update!(auth_team_hash)
    end
  end

  [:admin, :member].each do |membership_type|
    has_membership = "#{membership_type}?".to_sym

    define_method has_membership do |user|
      memberships.where(user: user).any? do |membership|
        membership.send(has_membership) && membership.approved?
      end
    end
  end
end
