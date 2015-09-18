module AuthHashTranslator
  class Team < Translator
    def translated_attributes
      {
        slack_team_id: info['team_id'],
        slack_team_domain: info['team_domain'],
        name: info['team']
      }.with_indifferent_access
    end
  end
end
