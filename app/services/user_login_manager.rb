class UserLoginManager
  def initialize(:user_info, :team_info, :membership_info)
    @user_info = user_info
    @team_info = team_info
    @membership_info = membership_info
  end

  def find_or_create

  end

  private

  attr_reader :user_info, :team_info, :membership_info

  def find_or_create_from_info
    @user = UserFinder.new(user_info).user
  end

  def find_or_create_user_and_team
    update_membership(
      MembershipModifier.create_membership(
        requesting_user: nil,
        target_user: UserFinder.new(info).user,
        joinable: TeamFinder.new(info).team,
        role: role
      )
    )
  end

  def update_membership(membership)
    membership.tap(&:update, {
      slack_access_token: credentials['token'],
      slack_uid: uid,
      role: user_is_team_admin? ? 1 : 0
    })
  end
end
