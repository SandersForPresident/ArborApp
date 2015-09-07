class AccountUser < ActiveRecord::Base
  belongs_to :account
  belongs_to :user

  enum role: [:user, :admin]
end
