class Membership < ActiveRecord::Base
  include AASM

  belongs_to :joinable, polymorphic: true
  belongs_to :user

  has_and_belongs_to_many :skills

  enum role: { member: 0, admin: 1 }

  validates :user, presence: true
  validates :joinable, presence: true
  validates :user, uniqueness: {
    scope: [:joinable_id, :joinable_type],
    message: 'should be unique for a user/joinable pair'
  }

  aasm do
    state :pending, initial: true
    state :approved

    event :approve do
      transitions from: :pending, to: :approved
    end
  end

  def self.find_or_create_with_auth_hash(user:, team:, auth_membership_hash:)
    find_or_initialize_by(
      user: user,
      joinable: team
    ).tap do |membership|
      membership.update!(auth_membership_hash)
    end
  end
end
