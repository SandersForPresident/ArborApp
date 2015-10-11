require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:user) { create :user }

  describe '#destroy' do
    it "deletes the cookie" do
      cookies.signed[:auth_token] = user.auth_token
      get :destroy
      token = cookies.signed[:auth_token]
      expect(token).to be_nil
    end

    it "changes the user's auth token" do
      cookies.signed[:auth_token] = user.auth_token
      current_token = user.auth_token.dup
      get :destroy
      expect(user.reload.auth_token).not_to eq current_token
    end
  end
end
