class User < ActiveRecord::Base
  class << self
    def find_or_create_from_auth_hash(auth_hash)
      user = User.find_or_create_by provider: auth_hash[:provider], uid: auth_hash[:uid]
      user.update avatar: auth_hash[:info][:image], name: auth_hash[:info][:name]
      user
    end
  end
end
