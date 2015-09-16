class JoinableBuilder
  class RequestingUserNotAdmin < StandardError; end
  class GroupNotInTeam < StandardError; end
  class NoTeamProvided < StandardError; end

  def self.build(requesting_user:, type:, attributes:)
    send("build_#{type}",
         requesting_user: requesting_user,
         attributes: attributes)
  end

  def self.build_team(requesting_user:, attributes:)
    team = Team.new(attributes)

    MembershipModifier.create_membership(requesting_user: nil,
                                         joinable: team,
                                         target_user: requesting_user,
                                         role: :admin)

    team
  end

  def self.build_group(requesting_user:, attributes:)
    parent_group = Group.find_by_id(attributes.delete(:parent_group_id))
    team = Team.find_by_id(attributes.delete(:team_id))

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
