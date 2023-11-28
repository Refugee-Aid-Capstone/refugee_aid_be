require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "relationships" do
    it { should belong_to :volunteer }
    it { should belong_to :organization }
  end

  describe "validations" do
    it { should validate_presence_of(:sender) }
    it { should validate_presence_of(:message_body) }
  end

  describe "instance methods" do
    describe "#sent_by" do
      it "returns the object representing who sent the message" do
        volunteer_message = create(:message, sender: 0) 
        expect(volunteer_message.sent_by).to be_a(Volunteer)

        org_message = create(:message, sender: 1)
        expect(org_message.sent_by).to be_an(Organization)
      end
    end

    describe "recipient" do
      it "returns the object representing who received the message" do
        volunteer_message = create(:message, sender: 0) 
        expect(volunteer_message.recipient).to be_an(Organization)

        org_message = create(:message, sender: 1)
        expect(org_message.recipient).to be_a(Volunteer)
      end
    end
  end
end
