require 'rails_helper'

RSpec.describe UserInitializer do
  describe '::initialize_and_return_user' do
    it 'returns user from auth hash' do
      user = UserInitializer.initialize_and_return_user(auth_hash)

      expect(user).to be_a User
      expect(user.email).to eq auth_hash_user_email
      expect(user.name).to eq auth_hash_user_name
    end

    context "when the indicated team doesn't exist" do
      it 'creates a new team' do
        expect do
          UserInitializer.initialize_and_return_user(auth_hash)
        end.to change(Team, :count).by(1)
      end

      it 'creates a new membership' do
        expect do
          UserInitializer.initialize_and_return_user(auth_hash)
        end.to change(Membership, :count).by(1)
      end
    end
  end
end
