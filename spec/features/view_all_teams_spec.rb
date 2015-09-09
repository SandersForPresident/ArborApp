require 'rails_helper'

RSpec.feature 'Users can view all teams', type: :feature do
  context 'when a user is on the team index page' do
    let!(:teams) { create_list(:team, 3) }

    before { visit '/teams' }

    scenario 'they see a list of all teams' do
      teams.each do |team|
        expect(page).to have_content(team.name)
      end
    end
  end
end
