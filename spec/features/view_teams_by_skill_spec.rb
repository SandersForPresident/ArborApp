require 'rails_helper'

RSpec.feature 'Users can view teams that need a selected skill', type: :feature do
  context 'when a user is on the index page' do
    let!(:skills) { create_list(:skill, 3) }

    before { visit '/' }

    scenario 'they see a list of skills' do
      skills.each do |skill|
        expect(page).to have_content(skill.name)
      end
    end

    context 'and they click a skill that some teams need' do
      let(:skill) { skills[1] }
      let(:teams) { create_list(:team, 3) }
      let!(:full_teams) { create_list(:team, 3) }

      before do
        teams.each do |team|
          team.skills << skill
          team.save
        end

        click_on(skill.name)
      end

      scenario 'they see a list of teams that need that skill' do
        teams.each do |team|
          expect(page).to have_content(team.name)
        end
      end

      scenario "they don't see teams that don't need that skill" do
        full_teams.each do |full_team|
          expect(page).not_to have_content(full_team.name)
        end
      end
    end
  end
end
