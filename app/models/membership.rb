class Membership < ActiveRecord::Base
  belongs_to :joinable, polymorphic: true
  belongs_to :user

  has_and_belongs_to_many :skills

  enum role: { member: 0, admin: 1 }
end
