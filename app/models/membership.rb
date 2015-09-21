class Membership < ActiveRecord::Base
  belongs_to :joinable, polymorphic: true
  belongs_to :user

  has_and_belongs_to_many :skills

  enum role: { member: 0, admin: 1 }

  def self.auth_find_or_create(user, team, auth_membership_hash)
    find_or_initialize_by(
      user: user,
      joinable: team
    ).tap do |membership|
      membership.update!(auth_membership_hash)
    end
  end
end
