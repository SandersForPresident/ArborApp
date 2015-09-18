[![Circle CI](https://circleci.com/gh/SandersForPresident/ArborApp.svg?style=svg)](https://circleci.com/gh/SandersForPresident/ArborApp)
[![Test Coverage](https://codeclimate.com/github/SandersForPresident/ArborApp/badges/coverage.svg)](https://codeclimate.com/github/SandersForPresident/ArborApp/coverage)
[![Code Climate](https://codeclimate.com/github/SandersForPresident/ArborApp/badges/gpa.svg)](https://codeclimate.com/github/SandersForPresident/ArborApp)

# ArborApp

A Rails application for recursive self-organizing teams with first-class Slack integration.

## Getting Started

### Dependencies

* [postgres](https://wiki.postgresql.org/wiki/Detailed_installation_guides) (`brew install postgres` on OSX and Homebrew)
* [npm](https://docs.npmjs.com/getting-started/installing-node) (`brew install node` on OSX and Homebrew)

### App Setup

Clone the application:

```bash
$ git clone git@github.com:SandersForPresident/ArborApp.git
```

Then install the dependencies and run the migrations:

```bash
$ bundle install
$ bundle exec rake db:create
$ bundle rake db:migrate
```

### Configuration

We use dotenv for configuration in development. You will need to create a file named .env in the root directory with the following contents:

```
SLACK_API_KEY=key
SLACK_API_SECRET=secret
```

Contact @schneidmaster in Slack to get the development key/secret.

### Start the Rails server

After installing and configuring, start a server on [http://localhost:3000](http://localhost:3000):

```bash
$ rails s
```

## Contributing

1. Fork it ( https://github.com/SandersForPresident/ArborApp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Ensure your changes still satisfy the tests and code linting (`bundle exec rspec` and `bundle exec rubocop`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
