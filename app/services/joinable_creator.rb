class JoinableCreator
  class RequestingUserNotAdmin < StandardError; end
  class GroupNotInTeam < StandardError; end
  class NoTeamProvided < StandardError; end

  def self.create_team(requesting_user:, attributes:, membership_attributes:)
    team = Team.create(attributes)

    MembershipModifier.create_membership(
      requesting_user: nil,
      joinable: team,
      target_user: requesting_user,
      attributes: membership_attributes
    )

    team
  end

  def self.create_group(requesting_user:, attributes:)
    team = Team.find_by_id(attributes.delete(:team_id))
    parent_group = Group.find_by_id(attributes.delete(:parent_group_id))

    if parent_group && (parent_group.team != team)
      fail JoinableCreator::GroupNotInTeam
    end

    fail JoinableCreator::NoTeamProvided unless team

    unless (parent_group || team).admin? requesting_user
      fail JoinableCreator::RequestingUserNotAdmin
    end

    Group.create(attributes.merge(team: team, parent_group: parent_group))
  end
end
