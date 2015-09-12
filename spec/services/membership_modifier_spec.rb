require 'rails_helper'

RSpec.describe MembershipModifier do
  let(:target_joinable) { FactoryGirl.create(:group) }
  let(:target_user) { FactoryGirl.create(:user) }
  let(:requesting_user) { FactoryGirl.create(:user) }

  describe '#destroy_membership' do
    context 'when target_user is a member of target_joinable' do
      before do
        FactoryGirl.create(:group_member_membership, user: target_user, joinable: target_joinable)
      end

      context 'and requesting_user is not an admin of target_joinable' do
        it 'does nothing' do
          MembershipModifier.destroy_membership(requesting_user: requesting_user,
                                                joinable: target_joinable,
                                                target_user: target_user)

          expect(target_joinable.member? target_user).to be_truthy
        end
      end

      context 'and requesting_user is an admin of target_joinable' do
        before { expect(target_joinable).to receive(:admin?).with(requesting_user) { true } }

        it "removes target_user's membership in target_joinable" do
          MembershipModifier.destroy_membership(requesting_user: requesting_user,
                                                joinable: target_joinable,
                                                target_user: target_user)

          expect(target_joinable.member? target_user).to be_falsy
        end
      end
    end
  end

  describe '#create_membership' do
    context 'when requesting_user is not an admin of target_joinable' do
      it 'does nothing' do
        MembershipModifier.create_membership(requesting_user: requesting_user,
                                             joinable: target_joinable,
                                             target_user: target_user,
                                             admin: false)

        expect(target_joinable.member? target_user).to be_falsy
      end
    end

    context 'when requesting_user is an admin of target_joinable' do
      before { expect(target_joinable).to receive(:admin?).with(requesting_user) { true } }

      context 'and the admin: false parameter is passed in' do
        it 'makes target_user a member of target_joinable' do
          MembershipModifier.create_membership(requesting_user: requesting_user,
                                               joinable: target_joinable,
                                               target_user: target_user,
                                               admin: false)

          expect(target_joinable.member? target_user).to be_truthy
        end
      end

      context 'and the admin: true parameter is passed in' do
        it 'makes target_user an admin of target_joinable' do
          MembershipModifier.create_membership(requesting_user: requesting_user,
                                               joinable: target_joinable,
                                               target_user: target_user,
                                               admin: true)

          expect(target_joinable).to receive(:admin?).and_call_original
          expect(target_joinable.admin?(target_user)).to be_truthy
        end
      end
    end
  end
end
