module Features
  module MockHelpers
    def mock_slack
      OmniAuth.config.add_mock(
        :slack,
        JSON.parse(File.read('spec/fixtures/slack_hash.json'))
      )
    end

    def mock_slack_failure
      OmniAuth.config.mock_auth[:slack] = :invalid_credentials
    end
  end
end
