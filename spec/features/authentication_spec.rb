require 'rails_helper'

RSpec.feature 'Authentication' do
  context 'using slack' do
    context 'when authentication succeeds' do
      before { mock_slack }

      scenario 'logs in the user' do
        visit '/auth/slack'
        expect(page).to have_content(
          t(
            'oauth_callbacks.show.success',
            email: 'someemail@email.com'
          )
        )
      end
    end

    context 'when authentication fails' do
      before { mock_slack_failure }

      scenario 'does not log in the user' do
        visit '/auth/slack'
        expect(page).to have_content(t('oauth_failures.show.failed'))
        expect(User.where(name: 'Joe Bloggs').count).to eq(0)
      end
    end
  end

  context 'when user is logged in' do
    before do
      mock_slack
      visit '/auth/slack'
    end

    scenario 'visiting "/logout" logs out the user' do
      visit '/logout'
      expect(page).to have_content(t('sessions.destroy.success'))
    end
  end
end
