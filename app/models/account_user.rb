class AccountUser < ActiveRecord::Base
  enum role: [:user, :admin]
end
