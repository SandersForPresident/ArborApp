require 'rails_helper'

RSpec.describe JoinableCreator do
  let(:requesting_user) { FactoryGirl.create(:user) }

  describe '::create_team' do
    let(:new_team_name) { 'Team Name' }
    let(:slack_team_id) { 'T3848YDDY' }
    let(:slack_team_domain) { 'somedomain' }
    let(:attributes) do
      {
        name: new_team_name,
        slack_team_domain: slack_team_domain,
        slack_team_id: slack_team_id
      }
    end
    let(:membership_attributes) do
      {
        role: 'admin'
      }
    end

    it 'creates a new team' do
      expect do
        JoinableCreator.create_team(
          requesting_user: requesting_user,
          attributes: attributes,
          membership_attributes: membership_attributes)
      end.to change(Team, :count).by(1)
    end

    it 'returns a newly created team with the passed in attributes' do
      expect(
        JoinableCreator.create_team(
          requesting_user: requesting_user,
          attributes: attributes,
          membership_attributes: membership_attributes).name
      ).to eq(new_team_name)
    end

    it 'makes the requesting_user an admin of the newly created team' do
      expect(
        JoinableCreator.create_team(
          requesting_user: requesting_user,
          attributes: attributes,
          membership_attributes: membership_attributes
        ).admin? requesting_user
      ).to eq(true)
    end
  end

  describe '::create_group' do
    let(:new_group_name) { 'Group Name' }
    let(:team) { FactoryGirl.create(:team) }
    let(:attributes) do
      {
        name: new_group_name,
        team_id: team.id
      }
    end

    context "when requesting_user is an admin of newly created group's \
            hierarchy" do
      before do
        FactoryGirl.create(:team_admin_membership,
                           user: requesting_user,
                           joinable: team).approve!
      end

      it 'creates a new group' do
        expect do
          JoinableCreator.create_group(
            requesting_user: requesting_user,
            attributes: attributes
          )
        end.to change(Group, :count).by(1)
      end

      it 'returns a newly created group with the passed in attributes' do
        expect(
          JoinableCreator.create_group(
            requesting_user: requesting_user,
            attributes: attributes
          ).name
        ).to eq(new_group_name)
      end

      it 'makes the requesting_user an admin of the newly created group' do
        expect(
          JoinableCreator.create_group(
            requesting_user: requesting_user,
            attributes: attributes
          ).admin? requesting_user
        ).to eq(true)
      end

      context 'when passed parent_group is not associated with passed team' do
        before { attributes.merge!(parent_group_id: parent_group.id) }

        let(:parent_group) { FactoryGirl.create(:group) }

        it 'raises a GroupNotInTeam exception' do
          expect do
            JoinableCreator.create_group(
              requesting_user: requesting_user,
              attributes: attributes
            )
          end.to raise_error(JoinableCreator::GroupNotInTeam)
        end
      end
    end

    context "when requesting_user is not an admin of newly created group's \
            hierarchy" do
      it 'raises a RequestingUserNotAdmin exception' do
        expect do
          JoinableCreator.create_group(
            requesting_user: requesting_user,
            attributes: attributes
          )
        end.to raise_error(JoinableCreator::RequestingUserNotAdmin)
      end
    end
  end
end
