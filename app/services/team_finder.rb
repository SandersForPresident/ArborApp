class TeamFinder
  def initialize(team_info)
    @team_info = team_info
  end

  def team
    find_or_create_team
  end

  private

  attr_reader :team_info

  def find_or_create_team
    Team.find_or_initialize_by(
      slack_team_id: team_info['team_id']
    ).tap do |team|
      update_team(team)
    end
  end

  def update_team(team)
    team.update!(
      slack_team_domain: team_info['team_domain'],
      name: team_info['team']
    )
  end
end
