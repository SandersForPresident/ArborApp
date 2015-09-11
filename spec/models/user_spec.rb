require 'rails_helper'

RSpec.describe User do
  context 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:slack_access_token) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:uid) }

    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
  end
end
