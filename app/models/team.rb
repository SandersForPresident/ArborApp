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

  def admin?(user)
    memberships.where(user: user).any? { |m| m.admin? && m.approved? }
  end

  def member?(user)
    memberships.where(user: user).any? { |m| m.member? && m.approved? }
  end
end
