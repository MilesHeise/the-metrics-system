require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:registered_application) { create(:registered_application) }
  let(:event) { create(:event, registered_application: registered_application) }

  it { is_expected.to belong_to(:registered_application) }

  it { is_expected.to validate_presence_of(:registered_application) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_length_of(:name).is_at_least(5) }

  describe 'attributes' do
    it 'has a registered_application_id attribute and a name attribute' do
      expect(event).to have_attributes(registered_application_id: event.registered_application_id, name: event.name)
    end
  end
end
