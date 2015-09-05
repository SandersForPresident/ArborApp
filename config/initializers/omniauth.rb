Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV['SLACK_API_KEY'], ENV['SLACK_API_SECRET'], scope: 'identify'
end
