require 'rails_helper'

RSpec.describe RegisteredApplication, type: :model do
  let(:user) { create(:user) }
  let(:registered_application) { create(:registered_application, user: user) }

  context 'Validations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:events) }

    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:url) }

    it { is_expected.to validate_length_of(:name).is_at_least(5) }
    it { is_expected.to validate_length_of(:url).is_at_least(10) }

    # context "url" do
    #   describe "uniqueness" do
    #     subject { build(:registered_application, name: 'longname') }
    #
    #     it { is_expected.to validate_uniqueness_of(:url).scoped_to(:user).with_message('You have already used this name') }
    #   end
    # end

    # it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user).with_message('You are already tracking this URL') }

    it { should_not allow_value('blah').for(:url) }
    it { should allow_value('https://examples.com').for(:url) }
  end

  describe 'attributes' do
    it 'has a name, url, and user attribute' do
      expect(registered_application).to have_attributes(name: registered_application.name, url: registered_application.url, user: registered_application.user)
    end
  end
end
