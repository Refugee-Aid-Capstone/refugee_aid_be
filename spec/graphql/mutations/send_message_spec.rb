require "rails_helper"

RSpec.describe Mutations::SendMessage do
  before do
    @send_message = <<~GraphQL
      mutation sendMessage($organizationId: Int!, $volunteerId: Int!, $messageBody: String!, $sender: String!) {
        sendMessage(organizationId: $organizationId, volunteerId: $volunteerId, messageBody: $messageBody, sender: $sender) {
          volunteer {
            id
            firstName
          }
          organization {
            id  
            name 
          }
          sender
          messageBody
        }
      }
    GraphQL

    @shelby = Volunteer.create!(first_name: "Shelby", last_name: "Jackson", email: "sjackson@example.com")
    @helpers = create(:organization, name: "Happy Helpers")
  end

  describe "given valid data" do
    it "creates a new message between a volunteer and organization" do

      expect(Message.count).to eq(0)
  
      from_shelby = RefugeeAidBeSchema.execute(@send_message, variables: { organizationId: @helpers.id, volunteerId: @shelby.id, messageBody: "Hello! I'd like to help!", sender: "volunteer" })
      from_helpers = RefugeeAidBeSchema.execute(@send_message, variables: { organizationId: @helpers.id, volunteerId: @shelby.id, messageBody: "Thanks so much! We'd love to have you!", sender: "organization" })
  
      expect(Message.count).to eq(2)
  
      expect(from_shelby.dig("data", "sendMessage", "sender")).to eq("volunteer")
      expect(from_shelby.dig("data", "sendMessage", "messageBody")).to eq("Hello! I'd like to help!")
      
      expect(from_helpers.dig("data", "sendMessage", "sender")).to eq("organization")
      expect(from_helpers.dig("data", "sendMessage", "messageBody")).to eq("Thanks so much! We'd love to have you!")
    end
  end

  describe "given invalid data" do
    it "throws an error if org or volunteer ids are invalid" do
      expect(Message.count).to eq(0)
  
      no_volunteer = RefugeeAidBeSchema.execute(@send_message, variables: { organizationId: @helpers.id, volunteerId: 0, messageBody: "Hello! I'd like to help!", sender: "volunteer" })
      no_org = RefugeeAidBeSchema.execute(@send_message, variables: { organizationId: 0, volunteerId: @shelby.id, messageBody: "Thanks so much! We'd love to have you!", sender: "organization" })
  
      expect(Message.count).to eq(0)      
    
      expect(no_volunteer.to_h["errors"][0]["message"]).to eq("Invalid input: Couldn't find Volunteer with 'id'=0")
      expect(no_org.to_h["errors"][0]["message"]).to eq("Invalid input: Couldn't find Organization with 'id'=0")
    end

    it "throws an error if message is blank" do
      no_message = RefugeeAidBeSchema.execute(@send_message, variables: { organizationId: @helpers.id, volunteerId: @shelby.id, messageBody: "", sender: "volunteer" })

      expect(no_message.to_h["errors"][0]["message"]).to eq("Validation failed: Message body can't be blank")
    end

    it "throws an error if sender is blank" do
      no_sender = RefugeeAidBeSchema.execute(@send_message, variables: { organizationId: @helpers.id, volunteerId: @shelby.id, messageBody: "Something", sender: "" })

      expect(no_sender.to_h["errors"][0]["message"]).to eq("Validation failed: Sender can't be blank")
    end
  end
end