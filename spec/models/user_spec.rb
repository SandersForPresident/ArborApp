require 'rails_helper'

RSpec.describe User do
  context 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email) }
  end
end
