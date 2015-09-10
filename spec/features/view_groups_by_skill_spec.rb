require 'rails_helper'

RSpec.feature 'Users can view groups that need a selected skill', type: :feature do
  context 'when a user is on the index page' do
    let!(:skills) { create_list(:skill, 3) }

    before { visit '/' }

    scenario 'they see a list of skills' do
      skills.each do |skill|
        expect(page).to have_content(skill.name)
      end
    end

    context 'and they click a skill that some groups need' do
      let(:skill) { skills[1] }
      let(:groups) { create_list(:group, 3) }
      let!(:full_groups) { create_list(:group, 3) }

      before do
        groups.each do |group|
          group.skills << skill
          group.save
        end

        click_on(skill.name)
      end

      scenario 'they see a list of groups that need that skill' do
        groups.each do |group|
          expect(page).to have_content(group.name)
        end
      end

      scenario "they don't see groups that don't need that skill" do
        full_groups.each do |full_group|
          expect(page).not_to have_content(full_group.name)
        end
      end
    end
  end
end
