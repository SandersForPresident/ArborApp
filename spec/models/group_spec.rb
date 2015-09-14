require 'rails_helper'

RSpec.describe Group, type: :model do
  describe '#admin?' do
    let(:user) { FactoryGirl.create(:user) }
    let(:group) { FactoryGirl.create(:group_with_grandparent) }

    context "when user is not an admin of the group, the group's team, or the\
            group's ancestors" do
      it 'returns a false value' do
        expect(group.admin? user).to eq(false)
      end
    end

    context 'when user is an admin of the group' do
      before do
        FactoryGirl.create(:group_admin_membership, user: user, joinable: group)
      end

      it 'returns true' do
        expect(group.admin? user).to eq(true)
      end
    end

    context "when user is an admin of the group's team" do
      before do
        FactoryGirl.create(
          :group_admin_membership,
          user: user,
          joinable: group.team
        )
      end

      it 'returns true' do
        expect(group.admin? user).to eq(true)
      end
    end

    context "when user is an admin of the group's parent_group" do
      before do
        FactoryGirl.create(
          :group_admin_membership,
          user: user,
          joinable: group.parent_group
        )
      end

      it 'returns true' do
        expect(group.admin? user).to eq(true)
      end
    end

    context "when user is an admin of the group's grandparent_group" do
      before do
        FactoryGirl.create(
          :group_admin_membership,
          user: user,
          joinable: group.parent_group.parent_group
        )
      end

      it 'returns true' do
        expect(group.admin? user).to eq(true)
      end
    end
  end
end
