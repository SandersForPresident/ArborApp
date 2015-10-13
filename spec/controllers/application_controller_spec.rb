require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      @current_user = current_user
      render text: @current_user
    end
  end

  let(:user) { create :user }

  describe '#current_user' do
    context 'valid cookie' do
      it 'sets the current_user' do
        cookies.signed[:auth_token] = user.auth_token
        get :index
        expect(assigns(:current_user)).to eq user
      end
    end

    context 'invalid cookie' do
      it 'does not set a current_user' do
        cookies.signed[:auth_token] = 'invalidrandom42'
        get :index
        expect(assigns(:current_user)).to eq nil
      end
    end
  end
end
