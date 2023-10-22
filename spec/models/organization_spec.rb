require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }

    it "validates at least one contact method is present" do
      org1 = build(:organization, contact_phone: "1234567890", contact_email: nil, street_address: nil)
      org2 = build(:organization, contact_phone: nil, contact_email: "example@test.com", street_address: nil)
      org3 = build(:organization, contact_phone: nil, contact_email: nil, street_address: "1234 Random Street")
      org4 = build(:organization, contact_phone: nil, contact_email: nil, street_address: nil)

      expect(org1.save).to eq(true)
      expect(org2.save).to eq(true)
      expect(org3.save).to eq(true)

      expect(org4.save).to eq(false)
      expect(org4.errors.full_messages.to_sentence).to eq("Please include either a phone number, email address, and/or street address and Please share at least one form of contact so volunteers may get in touch with you.")
    end

    it "validates at least one contact method is shared" do
      org1 = build(:organization, share_address: true, share_email: false, share_phone: false)
      org2 = build(:organization, share_address: false, share_email: true, share_phone: false)
      org3 = build(:organization, share_address: false, share_email: false, share_phone: true)
      org4 = build(:organization, share_address: false, share_email: false, share_phone: false)

      expect(org1.save).to eq(true)
      expect(org2.save).to eq(true)
      expect(org3.save).to eq(true)

      expect(org4.save).to eq(false)
      expect(org4.errors.full_messages.to_sentence).to eq("Please share at least one form of contact so volunteers may get in touch with you.")
    end
  end
end
