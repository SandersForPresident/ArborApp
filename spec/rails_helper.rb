ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'
require 'capybara/rspec'
require 'rack_session_access/capybara'
require 'shoulda/matchers'
require 'support/factory_girl'
require 'support/features/mock_helpers'
require 'support/features/auth_hash_helpers'
require 'support/i18n'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true, allow: %w(codeclimate.com))

ActiveRecord::Migration.maintain_test_schema!

OmniAuth.config.test_mode = true
OmniAuth.config.logger = Rails.logger

RSpec.configure do |config|
  config.include Features::MockHelpers, type: :feature
  config.include Features::AuthHashHelpers
  config.include Monban::Test::ControllerHelpers, type: :controller
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

  Capybara.configure do |capy|
    capy.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app)
    end
    capy.javascript_driver = :poltergeist
    capy.server_port = 5000
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.infer_spec_type_from_file_location!
end
