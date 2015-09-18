class JoinableBuilder
  class RequestingUserNotAdmin < StandardError; end
  class GroupNotInTeam < StandardError; end
  class NoTeamProvided < StandardError; end

  def self.build_team(requesting_user:, attributes:, membership_attributes:)
    ModelFinder.for(Team, attributes).find_or_initialize.tap do |team|
      MembershipModifier.find_or_initialize_membership(
        requesting_user: nil,
        joinable: team,
        target_user: requesting_user,
        attributes: membership_attributes
      )
    end
  end

  def self.build_group(requesting_user:, attributes:)
    team = Team.find_by_id(attributes.delete(:team_id))
    parent_group = Group.find_by_id(attributes.delete(:parent_group_id))

    if parent_group && (parent_group.team != team)
      fail JoinableBuilder::GroupNotInTeam
    end

    fail JoinableBuilder::NoTeamProvided unless team

    unless (parent_group || team).admin? requesting_user
      fail JoinableBuilder::RequestingUserNotAdmin
    end

    Group.new(attributes.merge(team: team, parent_group: parent_group))
  end
end
