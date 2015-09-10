require 'rails_helper'

RSpec.feature 'Users can view all groups', type: :feature do
  context 'when a user is on the group index page' do
    let!(:groups) { create_list(:group, 3) }

    before { visit '/groups' }

    scenario 'they see a list of all groups' do
      groups.each do |group|
        expect(page).to have_content(group.name)
      end
    end
  end
end
