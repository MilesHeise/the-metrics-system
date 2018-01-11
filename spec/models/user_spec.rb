require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to have_many(:registered_applications) }

  it { is_expected.to validate_presence_of(:username) }

  it { is_expected.to validate_uniqueness_of(:username) }

  describe 'attributes' do
    it 'should have username attribute' do
      expect(user).to have_attributes(username: user.username)
    end
  end
end
