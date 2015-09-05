feature 'Authentication' do
  context 'using slack' do
    context 'when authentication succeeds' do
      before { mock_slack }

      scenario 'logs in the user' do
        visit '/auth/slack'
        expect(page).to have_content('Logged in!')
        expect(User.where(name: 'Joe Bloggs').count).to eq(1)
      end
    end

    context 'when authentication fails' do
      before { mock_slack_failure }

      scenario 'does not log in the user' do
        visit '/auth/slack'
        expect(page).to have_content('Login failed. Please try again.')
        expect(User.where(name: 'Joe Bloggs').count).to eq(0)
      end
    end
  end

  context 'when user is logged in' do
    before do
      mock_slack
      visit '/auth/slack'
    end

    scenario 'logs out the user' do
      visit '/logout'
      expect(page).to have_content('Logged out!')
    end
  end
end
