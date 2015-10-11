require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do
  describe 'POST create' do
    let(:user) { FactoryGirl.create(:user) }
    let(:joinable) { FactoryGirl.create(:group) }

    context 'when user_id and joinable_id are valid' do
      context 'and user is not already a member of joinable' do
        it 'renders create.js' do
          post :create, membership: { user_id: user.id, group_id: joinable.id }
          expect(response).to render_template('memberships/create.js')
        end
      end

      context 'and user is already a member of joinable' do
        before do
          FactoryGirl.create(:membership, user: user, joinable: joinable)
        end

        it 'renders create_failure.js' do
          post :create, membership: { user_id: user.id, group_id: joinable.id }
          expect(response).to render_template('memberships/create_failure.js')
        end
      end
    end

    context 'when user_id is invalid' do
      it 'renders create_failure.js' do
        post :create, membership: { user_id: 'invalid-id', group_id: joinable.id }
        expect(response).to render_template('memberships/create_failure.js')
      end
    end

    context 'when joinable_id is invalid' do
      it 'renders create_failure.js' do
        post :create, membership: { user_id: user.id, group_id: 'invalid-id' }
        expect(response).to render_template('memberships/create_failure.js')
      end
    end
  end
end
