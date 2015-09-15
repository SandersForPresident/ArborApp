require 'rails_helper'

RSpec.describe JoinableBuilder do
  let(:requesting_user) { FactoryGirl.create(:user) }

  describe '#build_team' do
    let(:new_team_name) { 'Team Name' }
    let(:attributes) { { name: new_team_name } }

    it 'returns a newly built team with the passed in attributes' do
      expect(
        JoinableBuilder.build_team(requesting_user: requesting_user,
                                   attributes: attributes).name
      ).to eq(new_team_name)
    end

    it 'makes the requesting_user an admin of the newly built team' do
      expect(
        JoinableBuilder.build_team(
          requesting_user: requesting_user,
          attributes: attributes
        ).admin? requesting_user
      ).to eq(true)
    end
  end

  describe '#build_group' do
    let(:new_group_name) { 'Group Name' }
    let(:team) { FactoryGirl.create(:team) }
    let(:attributes) do
      {
        name: new_group_name,
        team_id: team.id
      }
    end

    context "when requesting_user is an admin of newly built group's \
            hierarchy" do
      before do
        FactoryGirl.create(:team_admin_membership,
                           user: requesting_user,
                           joinable: team)
      end

      it 'returns a newly built group with the passed in attributes' do
        expect(
          JoinableBuilder.build_group(requesting_user: requesting_user,
                                      attributes: attributes).name
        ).to eq(new_group_name)
      end

      it 'makes the requesting_user an admin of the newly built group' do
        expect(
          JoinableBuilder.build_group(
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
            JoinableBuilder.build_group(requesting_user: requesting_user,
                                        attributes: attributes)
          end.to raise_error(JoinableBuilder::GroupNotInTeam)
        end
      end
    end

    context "when requesting_user is not an admin of newly built group's \
            hierarchy" do
      it 'raises a RequestingUserNotAdmin exception' do
        expect do
          JoinableBuilder.build_group(requesting_user: requesting_user,
                                      attributes: attributes)
        end.to raise_error(ApplicationService::RequestingUserNotAdmin)
      end
    end
  end
end
