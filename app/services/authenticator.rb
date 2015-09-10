class Authenticator
  def initialize(auth_hash)
    @auth_hash = auth_hash
  end

  def authenticate
    find_or_create_user
  end

  private

  attr_reader :auth_hash

  def find_or_create_user
    User.find_or_initialize_by(
      provider: provider,
      uid: uid
    ).tap do |user|
      user_update(user)
    end
  end

  def user_update(user)
    user.update(
      avatar: info['image'],
      email: info['email'],
      name: info['name'],
      slack_access_token: credentials['token']
    )
  end

  def provider
    auth_hash['provider']
  end

  def uid
    auth_hash['uid']
  end

  def info
    auth_hash['info']
  end

  def credentials
    auth_hash['credentials']
  end
end
