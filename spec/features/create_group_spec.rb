require 'rails_helper'

RSpec.feature 'Admins can create groups', type: :feature do
  context 'when user is logged in' do
    let(:user) { User.last }

    before do
      mock_slack
      visit '/auth/slack'
    end

    context 'as an admin' do
      let(:team) { FactoryGirl.create(:team) }
      let(:other_team) { FactoryGirl.create(:team) }
      let(:group) { FactoryGirl.create(:group, team: team) }
      let(:other_group) { FactoryGirl.create(:group) }

      before do
        FactoryGirl.create(
          :team_admin_membership,
          user: user,
          joinable: team
        ).approve!
      end

      context "and visits their team's page" do
        before { visit team_path(team) }

        it 'they can create a group associated with their team' do
          click_on 'Create Group'
          fill_in 'Group Name', with: 'New Group Name'

          expect { click_on 'Create' }.to change(Group, :count).by 1

          new_group = Group.last

          expect(current_path).to eq(group_path(new_group))
        end
      end

      context "and visits their group's page" do
        before { visit group_path(group) }

        it 'they can create a group associated with their group' do
          click_on 'Create Sub-Group'
          fill_in 'Group Name', with: 'New Group Name'

          expect { click_on 'Create' }.to change(Group, :count).by 1

          new_group = Group.last

          expect(new_group.team).to eq(team)
          expect(new_group.parent_group).to eq(group)
          expect(current_path).to eq(group_path(new_group))
        end
      end

      context "and visits another team's page" do
        before { visit team_path(other_team) }

        it 'they cannot create a group associated with their team' do
          expect(page).not_to have_content('Create Group')
        end
      end

      context "and visits another group's page" do
        before { visit group_path(other_group) }

        it 'they cannot create a group associated with that group' do
          expect(page).not_to have_content('Create Sub-Group')
        end
      end
    end
  end
end
