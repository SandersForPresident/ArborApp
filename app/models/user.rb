class User < ActiveRecord::Base
  has_many :memberships
  has_many :teams,
           through: :memberships,
           source: :joinable,
           source_type: 'Team'
  has_many :groups,
           through: :memberships,
           source: :joinable,
           source_type: 'Group'

  validates :email, presence: true, uniqueness: true

  def self.find_or_create_with_auth_hash(auth_user_hash)
    find_or_initialize_by(
      email: auth_user_hash['email']
    ).tap do |user|
      user.update!(auth_user_hash)
    end
  end
end
