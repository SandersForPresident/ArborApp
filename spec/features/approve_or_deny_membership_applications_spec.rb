require 'rails_helper'

RSpec.feature 'Admin can approve or deny membership applications', type: :feature do
  let(:user) { User.last }
  let(:group) { FactoryGirl.create(:group) }

  before do
    mock_slack
    visit '/auth/slack'
  end

  context 'when a user is on a group page that they are already an admin of' do
    let!(:approved_membership) do
      FactoryGirl.create(:group_admin_membership,
                         user: user,
                         joinable: group).approve!
    end

    context 'and that group has pending membership applications' do
      let!(:pending_membership) do
        FactoryGirl.create(:group_member_membership,
                           joinable: group)
      end

      before do
        visit "/groups/#{group.id}"
      end

      scenario 'they see a "Pending Membership Applications" section' do
        expect(page).to have_content('Pending Membership Applications')
      end

      scenario 'they see a list of pending membership applications' do
        expect(page).to have_content(pending_membership.user.name)
      end

      scenario 'they see approve and deny buttons for each pending membership \
                applications' do
        expect(page).to have_selector(:link_or_button, 'Approve')
        expect(page).to have_selector(:link_or_button, 'Deny')
      end

      context 'and they click the approve button for a pending membership \
                application' do
        before { click_on 'Approve' }

        scenario 'they see the success message' do
          expect(page).to have_content('Membership Approved')
        end

        scenario "they don't see the approved membership application" do
          expect(page).to_not have_content(pending_membership.user.name)
        end
      end

      context 'and they click the deny button for a pending membership \
                application' do
        before { click_on 'Deny' }

        scenario 'they see the denied message' do
          expect(page).to have_content('Membership Denied')
        end

        scenario "they don't see the approved membership application" do
          expect(page).to_not have_content(pending_membership.user.name)
        end
      end
    end

    context 'and that group does not have pending membership applications' do
      before do
        visit "/groups/#{group.id}"
      end

      scenario 'they don\'t see a "Pending Membership Applications" section' do
        expect(page).to_not have_content('Pending Membership Applications')
      end
    end
  end
end
