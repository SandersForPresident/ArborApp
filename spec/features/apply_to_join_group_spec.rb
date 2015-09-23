require 'rails_helper'

RSpec.feature 'User can apply to join group', type: :feature do
  let(:user) { User.last }
  let(:group) { FactoryGirl.create(:group) }

  before do
    mock_slack
    visit '/auth/slack'
  end

  context 'when a user is on a group page that they are already a member of' do
    let(:approved_membership) do
      FactoryGirl.create(:group_admin_membership,
                         user: user,
                         joinable: group).approve!
    end

    before do
      approved_membership
      visit "/groups/#{group.id}"
    end

    scenario 'they don\'t see an "Application Pending" message' do
      expect(page).to_not have_content('Application Pending')
    end

    scenario 'they don\'t see the "Join Group" button' do
      expect(page).to_not have_selector(:link_or_button, 'Join Group')
    end
  end

  context 'when a user is on a group page that they have applied to' do
    let(:pending_membership) do
      FactoryGirl.create(:group_admin_membership,
                         user: user,
                         joinable: group)
    end

    before do
      pending_membership
      visit "/groups/#{group.id}"
    end

    scenario 'they see an "Application Pending" message' do
      expect(page).to have_content('Application Pending')
    end
  end

  context "when a user is on a group page that they haven't applied to" do
    before do
      visit "/groups/#{group.id}"
    end

    scenario 'they see a "Join Group" button' do
      expect(page).to have_selector(:link_or_button, 'Join Group')
    end

    scenario 'they don\'t see an "Application Pending" message' do
      expect(page).to_not have_content('Application Pending')
    end

    context 'and they click on the "Join Group" button' do
      before { click_on 'Join Group' }

      scenario 'they see a "Application Sent" message' do
        expect(page).to have_content('Application Sent')
      end

      scenario 'they don\'t see the "Join Group" button' do
        expect(page).to_not have_selector(:link_or_button, 'Join Group')
      end
    end
  end
end
