module ModelFinder
  class Team < Finder
    def find_or_initialize
      ::Team.find_or_initialize_by(
        slack_team_id: info['slack_team_id']
      ).tap do |team|
        update(team)
      end
    end
  end
end
