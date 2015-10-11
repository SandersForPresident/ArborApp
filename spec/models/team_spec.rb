require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:auth_team_hash) do
    {
      slack_team_id: 'T9999999',
      slack_team_domain: 'codersforsandersrules',
      name: 'Coders For Sanders'
    }.with_indifferent_access
  end
  context 'validations' do
    subject { build(:team) }

    it { is_expected.to validate_presence_of(:slack_team_id) }
  end

  describe '#admin?' do
    let(:user) { FactoryGirl.create(:user) }
    let(:team) { FactoryGirl.create(:team) }

    it 'returns true if user is an approved admin' do
      FactoryGirl.create(:team_admin_membership,
                         user: user, joinable: team).approve!

      expect(team.admin? user).to eq(true)
    end

    it 'returns false if user is an approved member' do
      FactoryGirl.create(:team_member_membership,
                         user: user, joinable: team).approve!

      expect(team.admin? user).to eq(false)
    end

    it 'returns false if user is an unapproved admin' do
      FactoryGirl.create(:team_admin_membership,
                         user: user, joinable: team)

      expect(team.admin? user).to eq(false)
    end

    it 'returns false if user is an unapproved member' do
      FactoryGirl.create(:team_member_membership,
                         user: user, joinable: team)

      expect(team.admin? user).to eq(false)
    end

    it 'returns false if user is not an admin or a member' do
      expect(team.admin? user).to eq(false)
    end
  end

  describe '::find_or_create_with_auth_hash' do
    it 'return a Team with the correct info' do
      team = Team.find_or_create_with_auth_hash(auth_team_hash)
      expect(team).to be_a Team
      expect(team.slack_team_id).to eq auth_team_hash['slack_team_id']
      expect(team.slack_team_domain).to eq auth_team_hash['slack_team_domain']
      expect(team.name).to eq auth_team_hash['name']
    end

    context 'team already exists' do
      before do
        FactoryGirl.create(
          :team,
          slack_team_id: auth_team_hash['slack_team_id'],
          name: auth_team_hash['name']
        )
      end

      it 'does not duplicate an existing team' do
        expect { Team.find_or_create_with_auth_hash(auth_team_hash) }.to_not(
          change(Team, :count)
        )
      end

      it 'updates the teams info' do
        team = Team.find_or_create_with_auth_hash(auth_team_hash)
        expect(team.name).to eq auth_team_hash['name']
      end
    end
  end
end
