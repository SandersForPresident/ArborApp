require 'rails_helper'

RSpec.feature 'Login Existing Users', type: :feature do
  before do
    mock_slack
    @user = FactoryGirl.create(
      :user,
      email: auth_hash_user_email,
      name: auth_hash_team_name
    )
  end

  context 'when an existing user logs in / signs up' do
    it 'finds the User from auth_hash' do
      expect { visit '/auth/slack' }.to_not change(User, :count)
    end

    context 'the Slack Team does NOT exist (user can have more than one)' do
      context 'it creates the team' do
        scenario 'and adds the user as admin (corresponding to Slack role)' do
          expect { visit '/auth/slack' }.to change(Team, :count).by 1
          team = Team.where(slack_team_id: auth_hash_team_id).first
          expect(
            team.admin?(User.where(email: auth_hash_user_email))
          ).to be true
        end
      end

      context 'it creates the team' do
        scenario 'and adds the user as member (corresponding to Slack role)' do
          mock_slack(auth_hash_not_admin)
          visit '/auth/slack'
          team = Team.where(slack_team_id: auth_hash_team_id).first
          expect(
            team.admin?(User.where(email: auth_hash_user_email))
          ).to be false
        end
      end
    end
  end
end
