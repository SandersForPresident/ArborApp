require 'rails_helper'

RSpec.describe Joinable, type: :concern do
  describe '#pending_application?' do
    let(:user) { FactoryGirl.create(:user) }
    let(:joinable) { FactoryGirl.create(:team) }

    context 'when passed in user has a pending application' do
      let!(:membership) do
        FactoryGirl.create(:membership, user: user, joinable: joinable)
      end

      it 'returns true' do
        expect(joinable.pending_application? user).to eq(true)
      end
    end

    context 'when passed in user does not have a pending application' do
      it 'returns false' do
        expect(joinable.pending_application? user).to eq(false)
      end
    end
  end
end
