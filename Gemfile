source 'https://rubygems.org'

ruby '2.2.3'

gem 'aasm'
gem 'bundler', '>= 1.8.4'
gem 'coffee-rails', '~> 4.1.0'
gem 'i18n-tasks'
gem 'jbuilder', '~> 2.0'
gem 'monban'
gem 'omniauth'
gem 'omniauth-slack'
gem 'rails', '4.2.4'
gem 'sass-rails', '~> 5.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'slack-ruby-client'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

source 'https://rails-assets.org' do
  gem 'rails-assets-berniestrap'
  gem 'rails-assets-jquery'
  gem 'rails-assets-jquery-ujs'
  gem 'rails-assets-rails-turbolinks'
end

group :production do
  gem 'pg'
  gem 'puma'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_girl_rails', '~> 4.4.1'
end

group :test do
  gem 'capybara', '~> 2.5.0'
  gem 'capybara-screenshot', '~> 1.0.11'
  gem 'codeclimate-test-reporter', require: false
  gem 'database_cleaner', '~> 1.3.0'
  gem 'faker', '~> 1.3.0'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'poltergeist', '~> 1.5.0'
  gem 'rack_session_access', '~> 0.1.1'
  gem 'rspec-rails', '~> 3.1'
  gem 'shoulda-matchers'
  gem 'simplecov', '~> 0.10.0'
  gem 'terminal-notifier-guard', '~> 1.6.1'
  gem 'webmock', '~> 1.18.0'
end

group :development do
  gem 'spring'
  gem 'web-console', '~> 2.0'
end
