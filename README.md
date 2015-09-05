[![Circle CI](https://circleci.com/gh/SandersForPresident/OrganizationApp.svg?style=svg)](https://circleci.com/gh/SandersForPresident/OrganizationApp)
[![Code Climate](https://codeclimate.com/github/SandersForPresident/OrganizationApp/badges/gpa.svg)](https://codeclimate.com/github/SandersForPresident/OrganizationApp)

# OrganizationApp

A Rails application for recursive self-organizing teams.

## Configuration

We use dotenv for configuration in development. You will need to create a file named .env in the root directory with the following contents:

```
SLACK_API_KEY=key
SLACK_API_SECRET=secret
```

Contact @schneidmaster in Slack to get the development key/secret.