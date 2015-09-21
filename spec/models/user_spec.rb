require 'rails_helper'

RSpec.describe User, type: :model do
  let(:auth_user_hash) do
    {
      email: 'dude@lebowski.com',
      name: 'Lebowski',
      avatar: 'http://thedude.jpg'
    }.with_indifferent_access
  end
  context 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email) }
  end

  describe '::find_or_create_with_auth_hash' do
    it 'return a User with the correct info' do
      user = User.find_or_create_with_auth_hash(auth_user_hash)
      expect(user).to be_a User
      expect(user.email).to eq auth_user_hash['email']
      expect(user.name).to eq auth_user_hash['name']
      expect(user.avatar).to eq auth_user_hash['avatar']
    end

    context 'user already exists' do
      before do
        FactoryGirl.create(
          :user,
          email: auth_user_hash['email'],
          name: auth_user_hash['name']
        )
      end

      it 'does not duplicate an existing user' do
        expect { User.find_or_create_with_auth_hash(auth_user_hash) }.to_not(
          change(User, :count)
        )
      end

      it 'updates the users info' do
        user = User.find_or_create_with_auth_hash(auth_user_hash)
        expect(user.avatar).to eq auth_user_hash['avatar']
      end
    end
  end
end
