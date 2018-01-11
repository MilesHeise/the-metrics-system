require 'rails_helper'

RSpec.describe RegisteredApplication, type: :model do
  let(:user) { create(:user) }
  let(:registered_application) { create(:registered_application, user: user) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:events) }

  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to validate_length_of(:name).is_at_least(5) }
  it { is_expected.to validate_length_of(:url).is_at_least(10) }

  describe 'attributes' do
    it 'has a name, url, and user attribute' do
      expect(registered_application).to have_attributes(name: registered_application.name, url: registered_application.url, user: registered_application.user)
    end
  end
end
