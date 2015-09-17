class SlackInfoTranslator

  def initialize(auth_hash)
    @auth_hash = auth_hash
  end

  def translate_to_user
    {
      email: info['email'],
      name: info['name'],
      avatar: info['image']
    }
  end

  def translate_to_team
    {
      slack_team_id: info['team_id'],
      slack_team_domain: info['team_domain'],
      name: info['team']
    }
  end

  def translate_to_membership
    {
      slack_uid: uid,
      slack_access_token: credentials['token'],
      role: team_role
    }
  end

  private

  attr_reader :auth_hash

  def slack_uid
    auth_hash['uid']
  end

  # Maybe change this -
  # not sure this should live here cause it's not "Slack" info
  def team_role
    return 'admin' if user_is_team_admin?
    'member'
  end

  def user_is_team_admin?
    info['is_admin']
  end

  def info
    auth_hash['info']
  end

  def credentials
    auth_hash['credentials']
  end
end
