require 'rails_helper'

RSpec.describe MembershipModifier do
  let(:target_joinable) { FactoryGirl.create(:group) }
  let(:target_user) { FactoryGirl.create(:user) }
  let(:requesting_user) { FactoryGirl.create(:user) }

  describe '#update_membership' do
    context 'when requesting_user is not an admin of target_joinable' do
      it 'raises a RequestingUserNotAdmin exception' do
        expect do
          MembershipModifier.update_membership(requesting_user: requesting_user,
                                               joinable: target_joinable,
                                               target_user: target_user,
                                               role: :admin)
        end.to raise_error(MembershipModifier::RequestingUserNotAdmin)
      end
    end

    context 'when requesting_user is an admin of target_joinable' do
      before do
        FactoryGirl.create(:group_admin_membership,
                           user: requesting_user,
                           joinable: target_joinable)
      end

      context 'and the target_user is an admin of target_joinable' do
        before do
          FactoryGirl.create(:group_admin_membership,
                             user: target_user,
                             joinable: target_joinable)
        end

        context 'and the admin: false parameter is passed in' do
          it "changes the target_user's membership to a member of\
             target_joinable" do
            MembershipModifier.update_membership(
              requesting_user: requesting_user,
              joinable: target_joinable,
              target_user: target_user,
              role: :member
            )

            expect(target_joinable.member? target_user).to be true
          end
        end
      end

      context 'and target_user is not an admin or member of target_joinable' do
        it 'raises a NoExistingMembership exception' do
          expect do
            MembershipModifier.update_membership(
              requesting_user: requesting_user,
              joinable: target_joinable,
              target_user: target_user,
              role: :admin
            )
          end.to raise_error(MembershipModifier::NoExistingMembership)
        end
      end
    end
  end

  describe '#destroy_membership' do
    context 'when target_user is a member of target_joinable' do
      before do
        FactoryGirl.create(:group_member_membership,
                           user: target_user,
                           joinable: target_joinable)
      end

      context 'and requesting_user is not an admin of target_joinable' do
        it 'raises a RequestingUserNotAdmin exception' do
          expect do
            MembershipModifier.destroy_membership(
              requesting_user: requesting_user,
              joinable: target_joinable,
              target_user: target_user
            )
          end.to raise_error(MembershipModifier::RequestingUserNotAdmin)
        end
      end

      context 'and requesting_user is an admin of target_joinable' do
        before do
          expect(target_joinable)
            .to receive(:admin?).with(requesting_user) { true }
        end

        it "removes target_user's membership in target_joinable" do
          MembershipModifier.destroy_membership(
            requesting_user: requesting_user,
            joinable: target_joinable,
            target_user: target_user
          )

          expect(target_joinable.member? target_user).to be false
        end
      end
    end
  end

  describe '#create_membership' do
    context 'when requesting_user is not an admin of target_joinable' do
      it 'raises a RequestingUserNotAdmin exception' do
        expect do
          MembershipModifier.create_membership(requesting_user: requesting_user,
                                               joinable: target_joinable,
                                               target_user: target_user,
                                               role: :member)
        end.to raise_error(MembershipModifier::RequestingUserNotAdmin)
      end
    end

    context 'when requesting_user is an admin of target_joinable' do
      before do
        FactoryGirl.create(:group_admin_membership,
                           user: requesting_user,
                           joinable: target_joinable)
      end

      context 'and target_user is not an admin or member of target_joinable' do
        context 'and the admin: false parameter is passed in' do
          it 'makes target_user a member of target_joinable' do
            MembershipModifier.create_membership(
              requesting_user: requesting_user,
              joinable: target_joinable,
              target_user: target_user,
              role: :member
            )

            expect(target_joinable.member? target_user).to be true
          end
        end

        context 'and the admin: true parameter is passed in' do
          it 'makes target_user an admin of target_joinable' do
            MembershipModifier.create_membership(
              requesting_user: requesting_user,
              joinable: target_joinable,
              target_user: target_user,
              role: :admin
            )

            expect(target_joinable).to receive(:admin?).and_call_original
            expect(target_joinable.admin?(target_user)).to be true
          end
        end
      end

      context 'and target_user is already an admin or member of\
              target_joinable' do
        before do
          FactoryGirl.create(:group_admin_membership,
                             user: target_user,
                             joinable: target_joinable)
        end

        it 'raises an ExistingMembership exception' do
          expect do
            MembershipModifier.create_membership(
              requesting_user: requesting_user,
              joinable: target_joinable,
              target_user: target_user,
              role: :admin
            )
          end.to raise_error(MembershipModifier::ExistingMembership)
        end
      end
    end
  end
end
