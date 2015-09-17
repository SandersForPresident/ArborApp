class Authenticator
  def initialize(auth_hash)
    @slack_info = SlackInfoTranslator.new(auth_hash)
  end

  def authenticate
    membership = find_or_create_user_and_team
    membership.user
  end

  private

  attr_reader :auth_hash

  def authenticate_user
    UserLoginManager.new({
      user_info: user_info,
      team_info: team_info,
      membership_info: membership_info
    })
  end

  def user_info
    {
      email: info['email'],
      name: info['name'],
      avatar: info['image']
    }
  end
end
