require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:contact_phone) }
    it { should validate_presence_of(:contact_email) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:website) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }

    it { should validate_inclusion_of(:share_address).in_array([true, false]) }
    it { should validate_inclusion_of(:share_phone).in_array([true, false]) }
    it { should validate_inclusion_of(:share_email).in_array([true, false]) }
  end
end
