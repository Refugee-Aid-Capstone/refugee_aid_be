require "rails_helper"

RSpec.describe :messages do
  
  it "returns all messages between a volunteer and organization by date" do
    shelby = Volunteer.create!(first_name: "Shelby", last_name: "Jackson", email: "sjackson@example.com")
    helpers = create(:organization, name: "Happy Helpers")
    Message.create(volunteer: shelby, organization: helpers, message_body: "Hello! I'd like to volunteer!", sender: 0)
    Message.create(volunteer: shelby, organization: helpers, message_body: "I speak Korean and can assist with language needs!", sender: 0)
    Message.create(volunteer: shelby, organization: helpers, message_body: "Hi Shelby, thank you for your interest!", sender: 1)
    Message.create(volunteer: shelby, organization: helpers, message_body: "Are you available to stop by tomorrow at 1pm?", sender: 1)
    Message.create(volunteer: shelby, organization: helpers, message_body: "Yes, I am! I will see you then!", sender: 0)
    create_list(:message, 10)

    query = <<~GraphQL 
      query getMessages($volunteerId: Int!, $organizationId: Int!){
        messages(volunteerId: $volunteerId, organizationId: $organizationId) {
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
    
    result = RefugeeAidBeSchema.execute(query, variables: { volunteerId: shelby.id, organizationId: helpers.id })

    expect(result).to be_a(GraphQL::Query::Result)

    messages = result.dig("data", "messages")

    expect(Message.count).to eq(15)
    expect(messages.count).to eq(5)

    convo = []
    messages.each_with_index do |message, index|
      expect(message.keys).to eq(["volunteer", "organization", "sender", "messageBody"])
      expect(message["volunteer"].keys).to eq(["id", "firstName"])
      expect(message["volunteer"]["id"]).to eq(shelby.id.to_s)
      expect(message["volunteer"]["firstName"]).to eq(shelby.first_name)
      expect(message["organization"].keys).to eq(["id", "name"])
      expect(message["organization"]["id"]).to eq(helpers.id.to_s)
      expect(message["organization"]["name"]).to eq(helpers.name)
      expect(message["sender"]).to eq("volunteer").or eq("organization")
      expect(message["messageBody"]).to be_a(String)
      convo << message["messageBody"]
    end

    expected = [
      "Hello! I'd like to volunteer!",
      "I speak Korean and can assist with language needs!",
      "Hi Shelby, thank you for your interest!",
      "Are you available to stop by tomorrow at 1pm?",
      "Yes, I am! I will see you then!"
    ]

    expect(convo).to eq(expected)
  end
end