require 'rails_helper'

RSpec.describe OauthCallbacksController, type: :controller do

  let(:user) { create :user }

  describe '#show' do
    it 'should set a cookie with an auth_token matching the user' do
      allow(UserInitializer).to receive(:initialize_and_return_user).
        with(nil).and_return(user)
      get :show, provider: 'slack'
      expect(cookies.signed[:auth_token]).to eq user.auth_token
    end
  end
end
