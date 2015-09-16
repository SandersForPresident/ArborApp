require 'rails_helper'

RSpec.describe Authenticator do
  describe '#authenticate' do
    it 'returns user from auth hash' do
      authenticator = Authenticator.new(auth_hash)

      authenticated_user = authenticator.authenticate

      expect(authenticated_user).to be_a User
      expect(authenticated_user.email).to eq auth_hash['info']['email']
      expect(authenticated_user.name).to eq auth_hash['info']['name']
    end

    context 'when the user does not exist' do
      it 'creates a user from auth_hash' do
        authenticator = Authenticator.new(auth_hash)
        expect { authenticator.authenticate }.to change(User, :count).by(1)
        authenticator = Authenticator.new(auth_hash_with_diff_email)
        expect { authenticator.authenticate }.to change(User, :count).by(1)
      end

      context 'but the team does exist' do
        it 'creates a user and adds it to the team' do
          team = create_team
          authenticated_user = Authenticator.new(auth_hash).authenticate
          expect(Team.count).to eq 1
          expect(authenticated_user.teams.count).to eq 1
          expect(authenticated_user.teams.first).to eq team
          expect(team.admin?(authenticated_user)).to be user_is_team_admin?
        end
      end
    end

    context 'when the user exists' do
      before(:each) do
        @user = FactoryGirl.create(
          :user,
          name: auth_hash['info']['name'],
          email: auth_hash['info']['email']
        )
      end

      context 'and is using a slack team that does not exist' do
        it 'creates a new team and adds the user' do
          authenticated_user = Authenticator.new(auth_hash).authenticate
          expect(authenticated_user).to eq @user
          expect(Team.count).to be 1
          expect(authenticated_user.teams.count).to be 1
          team = authenticated_user.teams.first
          expect(team.slack_team_id).to eq team_id
          expect(team.slack_team_domain).to eq team_domain
          expect(team.name).to eq team_name
        end
      end

      context 'and is using an existing slack team that they have not\
      joined on Arobor' do
        it 'creates a new membership and adds them to the team' do
          team = create_team
          authenticated_user = Authenticator.new(auth_hash).authenticate
          expect(authenticated_user).to eq @user
          expect(Team.count).to be 1
          expect(team.admin?(authenticated_user)).to eq user_is_team_admin?
        end
      end
    end
  end

  def create_team
    FactoryGirl.create(
      :team,
      slack_team_id: team_id,
      slack_team_domain: team_domain,
      name: team_name
    )
  end

  def team_name
    auth_hash['info']['team']
  end

  def team_domain
    auth_hash['info']['team_domain']
  end

  def team_id
    auth_hash['info']['team_id']
  end

  def user_is_team_admin?
    auth_hash['info']['is_admin']
  end

  def auth_hash
    @auth_hash ||= JSON.parse(File.read('spec/fixtures/slack_hash.json'))
  end

  def auth_hash_with_diff_uid
    hash = auth_hash
    hash['uid'] = 'mynewuid'
    hash
  end

  def auth_hash_with_diff_email
    hash = auth_hash
    hash['info']['email'] = 'myotheremail@other.com'
    hash
  end
end
