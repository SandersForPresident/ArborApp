[![Circle CI](https://circleci.com/gh/SandersForPresident/ArborApp.svg?style=svg)](https://circleci.com/gh/SandersForPresident/ArborApp)
[![Test Coverage](https://codeclimate.com/github/SandersForPresident/ArborApp/badges/coverage.svg)](https://codeclimate.com/github/SandersForPresident/ArborApp/coverage)
[![Code Climate](https://codeclimate.com/github/SandersForPresident/ArborApp/badges/gpa.svg)](https://codeclimate.com/github/SandersForPresident/ArborApp)

# ArborApp

A Rails application for recursive self-organizing teams.

## Getting Started

Install [postgres](https://wiki.postgresql.org/wiki/Detailed_installation_guides)

```
$bundle install
$bower install
$rake db:migrate
```

## Configuration

We use dotenv for configuration in development. You will need to create a file named .env in the root directory with the following contents:

```
SLACK_API_KEY=key
SLACK_API_SECRET=secret
```

Contact @schneidmaster in Slack to get the development key/secret.

## Assets

We use bower for frontend asset management. After cloning the application, run `bower install` to install frontend dependencies.

## Start the Rails server
```
$rails s
```
