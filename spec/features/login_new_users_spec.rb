require 'rails_helper'

RSpec.feature 'Login new users', type: :feature do
  before do
    mock_slack
  end

  context 'when a new user logs in / signs up' do
    it 'creates a User from auth_hash' do
      visit '/auth/slack'
      expect(User.where(email: auth_hash_user_email).count).to eq(1)
    end

    context 'the Slack Team does NOT exist' do
      context 'it creates the team' do
        scenario 'and adds the user as admin (Slack role)' do
          visit '/auth/slack'
          team = Team.where(slack_team_id: auth_hash_team_id).first
          expect(
            team.admin?(User.where(email: auth_hash_user_email).first)
          ).to be true
        end

        scenario 'and adds the slack uid and token to the membership' do
          visit '/auth/slack'
          membership = Membership.where(
            user: User.where(email: auth_hash_user_email)
          ).first
          expect(membership.slack_access_token).to eq(
            auth_hash_user_access_token
          )
        end
      end

      context 'it creates the team' do
        scenario 'and adds the user as member (Slack role)' do
          mock_slack(auth_hash_not_admin)
          visit '/auth/slack'
          team = Team.where(slack_team_id: auth_hash_team_id).first
          expect(
            team.admin?(User.where(email: auth_hash_user_email))
          ).to be false
        end
      end
    end

    context 'the Slack Team DOES exist' do
      before do
        @team = FactoryGirl.create(
          :team,
          slack_team_id: auth_hash_team_id,
          slack_team_domain: auth_hash_team_domain,
          name: auth_hash_team_name
        )
      end

      context 'it creates a user' do
        scenario 'and adds it to the team as admin (Slack role)' do
          expect { visit '/auth/slack' }.to_not change(Team, :count)
          expect(
            @team.admin?(User.where(email: auth_hash_user_email))
          ).to be true
        end

        scenario 'and adds it to the team as member (Slack role)' do
          mock_slack(auth_hash_not_admin)
          expect { visit '/auth/slack' }.to_not change(Team, :count)
          expect(
            @team.admin?(User.where(email: auth_hash_user_email))
          ).to be false
        end
      end
    end
  end
end
