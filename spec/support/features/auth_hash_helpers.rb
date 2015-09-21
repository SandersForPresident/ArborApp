module Features
  module AuthHashHelpers
    def auth_hash_user_email
      auth_hash_info['email']
    end

    def auth_hash_user_name
      auth_hash_info['name']
    end

    def auth_hash_user_access_token
      auth_hash_credentials['token']
    end

    def auth_hash_team_name
      auth_hash_info['team']
    end

    def auth_hash_team_domain
      auth_hash_info['team_domain']
    end

    def auth_hash_team_id
      auth_hash_info['team_id']
    end

    def auth_hash_info
      auth_hash['info']
    end

    def auth_hash_credentials
      auth_hash['credentials']
    end

    def auth_hash_not_admin
      hash = auth_hash
      hash['info']['is_admin'] = false
      hash
    end

    def auth_hash
      @auth_hash ||= JSON.parse(File.read('spec/fixtures/slack_hash.json'))
    end
  end
end
