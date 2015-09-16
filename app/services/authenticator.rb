class Authenticator
  def initialize(auth_hash)
    @auth_hash = auth_hash
  end

  def authenticate
    membership = find_or_create_user_and_team
    membership.user
  end

  private

  attr_reader :auth_hash

  def find_or_create_user_and_team
    Membership.find_or_initialize_by(
      user: find_or_create_user,
      joinable: find_or_create_team
    ).tap do |membership|
      update_membership(membership)
    end
  end

  def update_membership(membership)
    membership.update!(
      slack_access_token: credentials['token'],
      slack_uid: uid,
      role: user_is_team_admin? ? 1 : 0
    )
  end

  def find_or_create_user
    User.find_or_initialize_by(
      email: info['email']
    ).tap do |user|
      user_update(user)
    end
  end

  def user_update(user)
    user.update!(
      avatar: info['image'],
      name: info['name']
    )
  end

  def find_or_create_team
    Team.find_or_initialize_by(
      slack_team_id: info['team_id']
    ).tap do |team|
      update_team(team)
    end
  end

  def update_team(team)
    team.update!(
      slack_team_domain: info['team_domain'],
      name: info['team']
    )
  end

  def user_is_team_admin?
    info['is_admin']
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
