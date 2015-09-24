require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do
  describe 'PUT deny' do
    context 'when passed id is the id of a pending membership' do
      let(:user) { FactoryGirl.create(:user) }
      let(:joinable) { FactoryGirl.create(:group) }
      let!(:membership) { FactoryGirl.create(:membership, joinable: joinable) }

      context "and current_user is admin of the membership's joinable" do
        before do
          FactoryGirl.create(:group_admin_membership,
                             user: user,
                             joinable: joinable).approve!
          allow(subject).to receive(:current_user).and_return(user)
        end

        it 'denies the membership' do
          put :deny, id: membership.id
          expect(membership.reload.denied?).to eq(true)
        end
      end

      context "and current_user is not admin of the membership's joinable" do
        before do
          allow(subject).to receive(:current_user).and_return(user)
        end

        it 'renders deny_failure.js' do
          put :deny, id: membership.id
          expect(response).to render_template('memberships/deny_failure.js')
        end
      end

      context 'and user is not signed in' do
        it 'renders deny_failure.js' do
          put :deny, id: membership.id
          expect(response).to render_template('memberships/deny_failure.js')
        end
      end
    end

    context 'when passed id is not the id of a pending membership' do
      it 'renders deny_failure.js' do
        put :deny, id: 'invalid-id'
        expect(response).to render_template('memberships/deny_failure.js')
      end
    end
  end

  describe 'PUT approve' do
    context 'when passed id is the id of a pending membership' do
      let(:user) { FactoryGirl.create(:user) }
      let(:joinable) { FactoryGirl.create(:group) }
      let!(:membership) { FactoryGirl.create(:membership, joinable: joinable) }

      context "and current_user is admin of the membership's joinable" do
        before do
          FactoryGirl.create(:group_admin_membership,
                             user: user,
                             joinable: joinable).approve!
          allow(subject).to receive(:current_user).and_return(user)
        end

        it 'approves the membership' do
          put :approve, id: membership.id
          expect(membership.reload.approved?).to eq(true)
        end
      end

      context "and current_user is not admin of the membership's joinable" do
        before do
          allow(subject).to receive(:current_user).and_return(user)
        end

        it 'renders approve_failure.js' do
          put :approve, id: membership.id
          expect(response).to render_template('memberships/approve_failure.js')
        end
      end

      context 'and user is not signed in' do
        it 'renders approve_failure.js' do
          put :approve, id: membership.id
          expect(response).to render_template('memberships/approve_failure.js')
        end
      end
    end

    context 'when passed id is not the id of a pending membership' do
      it 'renders approve_failure.js' do
        put :approve, id: 'invalid-id'
        expect(response).to render_template('memberships/approve_failure.js')
      end
    end
  end

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
