module Features
  module MockHelpers
    def mock_slack(hash = auth_hash)
      OmniAuth.config.add_mock(
        :slack,
        hash
      )
    end

    def mock_slack_failure
      OmniAuth.config.mock_auth[:slack] = :invalid_credentials
    end
  end
end
